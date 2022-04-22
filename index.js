require("dotenv").config();
const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const app = express();
const mysql = require("mysql");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const saltRounds = 10;
const multer = require("multer");
const path = require("path");
const config = require("./config");
var nodemailer = require("nodemailer");
// const pino = require('express-pino-logger')();
const { videoToken } = require("./tokens");
app.use(express.json());
app.use(cors());

app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);
// app.use(pino);

const sendTokenResponse = (token, res) => {
  res.set("Content-Type", "application/json");
  res.send(
    JSON.stringify({
      token: token.toJwt(),
    })
  );
};

app.get("/api/greeting", (req, res) => {
  const name = req.query.name || "World";
  res.setHeader("Content-Type", "application/json");
  res.send(JSON.stringify({ greeting: `Hello ${name}!` }));
});

app.get("/video/token", (req, res) => {
  const identity = req.query.identity;
  const room = req.query.room;
  const token = videoToken(identity, room, config);
  sendTokenResponse(token, res);
});
app.post("/video/token", (req, res) => {
  const identity = req.body.identity;
  const room = req.body.room;
  const token = videoToken(identity, room, config);
  sendTokenResponse(token, res);
});

//Table of Contents
//CreateConnection
//Home
//Token
//Login, Logout, Register API pet Owners
//Get, Delete, Update Pet Owner
//Get, Delete, Update Pets
//Get Verified & Pending, Add, Delete, Update, Approved Vet Clinic
//Get, Add, Delete, and Update Products
//Get, Add, Delete, and Update Services
//Get, Add, Delete, and Update Pharmacy
//Get and Add History
//dashboard get data system admin
//dashboard get data vet clinic admin
//Appointment Get, Add, Delete, Update
//Talk to Vet
//Authenticate Token
//GenerateAccessToken
//Get, Add, Delete, and Update Ratings& Feedback
// Email Verification

//--------------------------------------------------------------------------//
// const db = mysql.createConnection({
//   host: "localhost",
//   user: "root",
//   password: "",
//   database: "terravet",
// });

const db = mysql.createPool({
  connectionLimit: 1000,
  connectTimeout: 60 * 60 * 1000,
  acquireTimeout: 60 * 60 * 1000,
  timeout: 60 * 60 * 1000,
  host: "us-cdbr-east-05.cleardb.net",
  user: "bdb2dd6ba41ba9",
  password: "9542972d",
  database: "heroku_9d423aff4dc7247",
});

// console.log(db);

//--------------------------------------------------------------------------//
app.get("/home", authenticateToken, (req, res) => {
  res.send(req.user);
});

//--------------------------------------------------------------------------//
let refreshTokens = [];

app.post("/token", (req, res) => {
  const refreshToken = req.body.token;
  if (refreshToken == null) return res.sendStatus(401);
  if (!refreshTokens.includes(refreshToken)) return res.sendStatus(403);
  jwt.verify(refreshToken, process.env.REFRESH_TOKEN_SECRET, (err, user) => {
    if (err) return res.sendStatus(403);
    const accessToken = generateAccessToken({ name: user.name });
    res.json({ accessToken: accessToken });
  });
});
//--------------------------------------------------------------------------//

//login API
app.post("/api/login", (req, res) => {
  //Authenticate
  // console.log("here");
  const email = req.body.email;
  const password = req.body.password;
  console.log(email + " " + password);
  let role;
  db.query("SELECT * FROM user_role WHERE email = ?", email, (err, result) => {
    if (err) {
      res.send({ err: err });
    }

    if (result.length > 0) {
      role = result[0].userrole;
      if (result[0].userrole == 1) {
        db.query(
          "SELECT * FROM pet_owners WHERE email = ? AND isArchived = 'False'",
          email,
          (err, result) => {
            if (err) {
              res.send({ err: err });
            }

            // -----------------------------------------
            if (result.length > 0) {
              bcrypt.compare(
                password,
                result[0].password,
                (error, response) => {
                  if (response) {
                    if (result[0].isOnline == true) {
                      res.send({ message: "Already login with other device" });
                    } else {
                      result[0].password = "";
                      const user = { result };
                      // console.log(user)
                      const accessToken = generateAccessToken(user);
                      const refreshToken = jwt.sign(
                        user,
                        process.env.REFRESH_TOKEN_SECRET
                      );
                      refreshTokens.push(refreshToken);
                      let u = JSON.parse(JSON.stringify(user));
                      // console.log(u.result[0].name)
                      res.send({
                        accessToken: accessToken,
                        refreshToken: refreshToken,
                        message: "Correct",
                        role: 1,
                        user: JSON.parse(JSON.stringify(result[0])),
                      });
                    }
                  } else {
                    res.send({ message: "Wrong password!" });
                  }
                }
              );
            } else {
              res.send({ message: "User doesn't exist..." });
            }
            // --------------------------------------------
          }
        );
      } else if (result[0].userrole == 2) {
        db.query(
          "SELECT * FROM vet_clinic WHERE email = ? AND isArchived = 'False'",
          email,
          (err, result) => {
            if (err) {
              res.send({ err: err });
            }
            console.log("here");
            if (result.length > 0) {
              bcrypt.compare(
                password,
                result[0].password,
                (error, response) => {
                  if (response) {
                    if (result[0].isOnline == true) {
                      res.send({ message: "Already login with other device" });
                    } else {
                      result[0].password = "";
                      const user = { result };
                      // console.log(user)
                      const accessToken = generateAccessToken(user);
                      const refreshToken = jwt.sign(
                        user,
                        process.env.REFRESH_TOKEN_SECRET
                      );
                      refreshTokens.push(refreshToken);
                      let u = JSON.parse(JSON.stringify(user));
                      // console.log(u.result[0].name)
                      db.query(
                        "UPDATE vet_clinic SET isOnline = ? WHERE vet_admin_id = ?",
                        [true, result[0].vet_admin_id]
                      );
                      res.send({
                        accessToken: accessToken,
                        refreshToken: refreshToken,
                        message: "Correct",
                        role: 2,
                        vetStatus: result[0].vet_status,
                        id: result[0].vet_admin_id,
                        user: JSON.parse(JSON.stringify(result[0])),
                      });
                    }
                  } else {
                    res.send({ message: "Wrong password!" });
                  }
                }
              );
            } else {
              res.send({ message: "User doesn't exist..." });
            }
          }
        );
      } else if (result[0].userrole == 3) {
        // console.log("system admin");
        db.query(
          "SELECT * FROM system_administrator WHERE email = ? AND isArchived = 'False'",
          email,
          (err, result) => {
            if (err) {
              res.send({ err: err });
            }

            if (result.length > 0) {
              bcrypt.compare(
                password,
                result[0].password,
                (error, response) => {
                  if (response) {
                    if (result[0].isOnline == true) {
                      res.send({ message: "Already login with other device" });
                    } else {
                      result[0].password = "";
                      const user = { result };
                      // console.log(user)
                      const accessToken = generateAccessToken(user);
                      const refreshToken = jwt.sign(
                        user,
                        process.env.REFRESH_TOKEN_SECRET
                      );
                      refreshTokens.push(refreshToken);
                      let u = JSON.parse(JSON.stringify(user));
                      console.log(result[0]);
                      res.send({
                        accessToken: accessToken,
                        refreshToken: refreshToken,
                        message: "Correct",
                        role: 3,
                        user: JSON.parse(JSON.stringify(result[0])),
                      });
                    }
                  } else {
                    res.send({ message: "Wrong password!" });
                  }
                }
              );
            } else {
              res.send({ message: "User doesn't exist..." });
            }
          }
        );
      } else if (result[0].userrole == 4) {
        // console.log("system admin");
        db.query(
          "SELECT * FROM vet_doctors WHERE vet_doc_email = ? AND isArchived = 'False'",
          email,
          (err, result) => {
            if (err) {
              res.send({ err: err });
            }
            if (result.length > 0) {
              bcrypt.compare(
                password,
                result[0].vet_doc_password,
                (error, response) => {
                  if (response) {
                    if (result[0].isOnline == true) {
                      res.send({ message: "Already login with other device" });
                    } else if (result[0].isVerified == false) {
                      res.send({ message: "Your account is not verified" });
                    } else {
                      result[0].vet_doc_password = "";
                      const user = { result };
                      // console.log(user)
                      const accessToken = generateAccessToken(user);
                      const refreshToken = jwt.sign(
                        user,
                        process.env.REFRESH_TOKEN_SECRET
                      );
                      refreshTokens.push(refreshToken);
                      let u = JSON.parse(JSON.stringify(user));
                      console.log(result[0]);
                      db.query(
                        "UPDATE vet_doctors SET isOnline = ? WHERE vet_doc_id = ?",
                        [true, result[0].vet_doc_id]
                      );
                      res.send({
                        accessToken: accessToken,
                        refreshToken: refreshToken,
                        message: "Correct",
                        role: 4,
                        user: JSON.parse(JSON.stringify(result[0])),
                      });
                    }
                  } else {
                    res.send({ message: "Wrong password!" });
                  }
                }
              );
            } else {
              res.send({ message: "User doesn't exist..." });
            }
          }
        );
      } else if (result[0].userrole == 5) {
        // console.log("system admin");
        db.query(
          "SELECT * FROM vet_staff WHERE vet_staff_email = ? AND isArchived = 'False'",
          email,
          (err, result) => {
            if (err) {
              res.send({ err: err });
            }

            if (result.length > 0) {
              bcrypt.compare(
                password,
                result[0].vet_staff_password,
                (error, response) => {
                  if (response) {
                    if (result[0].isOnline == true) {
                      res.send({ message: "Already login with other device" });
                    } else if (result[0].isVerified == false) {
                      res.send({ message: "Your account is not verified" });
                    } else {
                      result[0].vet_staff_password = "";
                      const user = { result };
                      // console.log(user)
                      const accessToken = generateAccessToken(user);
                      const refreshToken = jwt.sign(
                        user,
                        process.env.REFRESH_TOKEN_SECRET
                      );
                      refreshTokens.push(refreshToken);
                      let u = JSON.parse(JSON.stringify(user));
                      console.log(result[0]);
                      db.query(
                        "UPDATE vet_staff SET isOnline = ? WHERE vet_staff_id = ?",
                        [true, result[0].vet_staff_id]
                      );
                      res.send({
                        accessToken: accessToken,
                        refreshToken: refreshToken,
                        message: "Correct",
                        role: 5,
                        user: JSON.parse(JSON.stringify(result[0])),
                      });
                    }
                  } else {
                    res.send({ message: "Wrong password!" });
                  }
                }
              );
            } else {
              res.send({ message: "User doesn't exist..." });
            }
          }
        );
      }

      // ---------- End line
    } else {
      res.send({ message: "User doesn't exist..." });
    }
  });
});

app.delete("/logout", (req, res) => {
  refreshTokens = refreshTokens.filter((token) => token !== req.body.token);
  res.sendStatus(204);
});

app.post("/register/petowner", (req, res) => {
  const email = req.body.email;
  const password = req.body.password;
  const name = req.body.name;
  const address = req.body.address;
  const contactNumber = req.body.contactNumber;
  const profile_petowner = req.body.profile_petowner;
  // const imageUrl = req.body.profile_petowner;
  // console.log(name);

  // console.log(uploadpetowner.single(profile_petowner));
  //   const imageUrl = `http://localhost:3001/profile/petowner/${req.file.filename}`;

  db.query(
    "INSERT INTO user_role (email,userrole,phone_number) VALUES (?,?,?)",
    [email, 1, contactNumber],
    (err, result) => {
      console.log("no error registering");
    }
  );

  bcrypt.hash(password, saltRounds, (err, hash) => {
    if (err) {
      console.log(err);
    }

    db.query(
      "INSERT INTO pet_owners (email,password,name,address,contact_number,profilePicture) VALUES (?,?,?,?,?,?)",
      [email, hash, name, address, contactNumber, profile_petowner],
      (err, result) => {
        console.log(err);
        res.send({
          message: "Registered",
        });
      }
    );
  });
});

//system administrator registration
app.post("/register/systemAdmin", (req, res) => {
  const email = req.body.email;
  const password = req.body.password;
  const name = req.body.name;
  const contactNumber = req.body.contactNumber;
  const profile_petowner = req.body.profile_petowner;

  db.query(
    "INSERT INTO user_role (email,userrole,phone_number) VALUES (?,?,?)",
    [email, 3, contactNumber],
    (err, result) => {
      console.log("no error registering");
    }
  );

  bcrypt.hash(password, saltRounds, (err, hash) => {
    if (err) {
      console.log(err);
    }

    db.query(
      "INSERT INTO system_administrator (email,password,name,profilePicture,phone_number) VALUES (?,?,?,?,?)",
      [email, hash, name, profile_petowner, contactNumber],
      (err, result) => {
        console.log(err);
        res.send({
          message: "Registered",
        });
      }
    );
  });
});

// --------------------------------------------------------------------------------------------------- Get, Delete, Update Pet Owner
//this api is for petowner
//get petowner data
app.get("/petowner", (req, res) => {
  const sqlQuery = "SELECT * FROM pet_owners WHERE isArchived = 'False'";
  db.query(sqlQuery, (err, result) => {
    // console.log(err);
    res.send(result);
  });
});

//get specific petowner data
app.get("/vetclinic/petowner/:pet_owner_id", (req, res) => {
  const pet_owner_id = req.params.pet_owner_id;
  // console.log(pet_owner_id);
  const sqlQuery = "SELECT name FROM pet_owners WHERE pet_owner_id = ?";
  db.query(sqlQuery, pet_owner_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//Archived pet owner
app.put("/petowner/archived/:petowner_id", (req, res) => {
  const petowner_id = req.params.petowner_id;
  // console.log(petowner_id);
  const sqlQuery =
    "UPDATE pet_owners SET isArchived = 1 WHERE pet_owner_id = ?";
  db.query(sqlQuery, petowner_id, (err, result) => {
    console.log("Archived");
    if (err != null) {
      console.log(err);
    }
  });
});

app.post("/api/login/mobile", (req, res) => {
  const email = req.body.email;
  const password = req.body.password;

  console.log(email + " " + password);

  db.query("SELECT * FROM user_role WHERE email = ?", email, (err, result) => {
    console.log(result);
    if (result.length > 0) {
      db.query(
        "SELECT * FROM pet_owners WHERE email = ?",
        email,
        (err, result) => {
          if (result.length > 0) {
            bcrypt.compare(password, result[0].password, (error, response) => {
              console.log(error);
              if (response) {
                console.log(result);
                res.send({ message: "Correct", user: result });
              } else {
                res.send({ message: "Incorrect Email/Password combination" });
              }
            });
          } else {
            res.send({ message: "Incorrect Email/Password combination" });
          }
        }
      );
    } else {
      res.send({ message: "Incorrect Email/Password combination" });
    }
  });
});

app.post("/api/update/credentials/mobile", (req, res) => {
  const email = req.body.email;

  console.log(email);

  db.query("SELECT * FROM pet_owners WHERE email = ?", email, (err, result) => {
    if (result.length > 0) {
      console.log(result);
      res.send({ message: "Correct", user: result });
    }
  });
});

app.post("/api/signup/mobile", (req, res) => {
  const email = req.body.email;
  const password = req.body.password;
  const name = req.body.name;
  const address = req.body.address;
  const contact_number = req.body.contactNumber;
  const profilePicture = req.body.profilePicture;

  console.log(email + " " + password);

  db.query(
    "INSERT INTO user_role (email,userrole,phone_number) VALUES (?,?,?)",
    [email, 1, contact_number],
    (err, result) => {
      console.log("no error registering");
    }
  );

  bcrypt.hash(password, saltRounds, (err, hash) => {
    if (err) {
      console.log(err);
    }

    db.query(
      "INSERT INTO pet_owners (email,password,name,address,contact_number,profilePicture) VALUES (?,?,?,?,?,?)",
      [email, hash, name, address, contact_number, profilePicture],
      (err, result) => {
        console.log(err);
        res.send({
          message: "Registered",
        });
      }
    );
  });
});

// get Emails validation
app.get("/users", (req, res) => {
  const sqlQuery = "SELECT email FROM user_role";
  db.query(sqlQuery, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

// get phone number validation
app.get("/phone_number", (req, res) => {
  const sqlQuery = "SELECT phone_number FROM user_role";
  db.query(sqlQuery, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//---------------------------------------------Get, Delete, Update Pets-----------------------------------------------//

//this api is for pets
app.get("/pets", (req, res) => {
  const sqlQuery = "SELECT * FROM pets WHERE isArchived = 'False'";
  db.query(sqlQuery, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

app.get("/pets/information/:petid", (req, res) => {
  const pet_id = req.params.petid;
  // console.log(pet_id);
  const sqlQuery = "SELECT * FROM pets WHERE pet_id = ?";
  db.query(sqlQuery, pet_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

app.get("/pets/:pet_owner_id", (req, res) => {
  const pet_owner_id = req.params.pet_owner_id;
  // console.log(pet_owner_id);
  const sqlQuery =
    "SELECT * FROM pets WHERE pet_owner_id = ? AND isArchived = 'False' ORDER BY pet_id DESC";
  db.query(sqlQuery, pet_owner_id.substring(1), (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

app.get("/pets/records/:vet_admin_id", (req, res) => {
  const vet_admin_id = req.params.vet_admin_id;
  // console.log(vet_admin_id);
  const sqlQuery =
    "SELECT * FROM pet_registry_for_vet JOIN pets ON pet_registry_for_vet.pet_id = pets.pet_id WHERE pet_registry_for_vet.vet_admin_id = ?";
  db.query(sqlQuery, vet_admin_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

app.get("/pets/appointment/submit/:pet_owner_id", (req, res) => {
  const pet_owner_id = req.params.pet_owner_id;
  // console.log(pet_owner_id);
  const sqlQuery = "SELECT * FROM pets WHERE pet_owner_id = ?";
  db.query(sqlQuery, pet_owner_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

app.get("/pets/appointment/defaultpet/:pet_owner_id", (req, res) => {
  const pet_owner_id = req.params.pet_owner_id;
  // console.log(pet_owner_id);
  const sqlQuery = "SELECT * FROM pets WHERE pet_owner_id = ?";
  db.query(sqlQuery, pet_owner_id, (err, result) => {
    // console.log(result);
    res.send(result[0]);
  });
});

app.get("/pets/appointment/:pet_id", (req, res) => {
  const pet_id = req.params.pet_id;
  // console.log(pet_id);
  const sqlQuery = "SELECT * FROM pets WHERE pet_id = ?";
  db.query(sqlQuery, pet_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

app.post("/pets/insert", (req, res) => {
  const ownerId = req.body.petOwnerId;
  const ownerName = req.body.petOwnerName;
  const petname = req.body.petname;
  const typeOfPet = req.body.typeOfPet;
  const breedOfPet = req.body.breedOfPet;
  const genderOfPet = req.body.genderOfPet;
  const birthDate = req.body.birthDate;
  const imageUrl = req.body.imageUrl;

  const sqlQuery =
    "INSERT INTO pets (pet_owner_id,pet_owner_name,pet_name,type_of_pet,breed_of_pet,gender,birth_day,pet_picture) VALUES (?,?,?,?,?,?,?,?)";
  db.query(
    sqlQuery,
    [
      ownerId,
      ownerName,
      petname,
      typeOfPet,
      breedOfPet,
      genderOfPet,
      birthDate,
      imageUrl,
    ],
    (err, result) => {
      console.log(err);
    }
  );
});

app.put("/pets/archived/:pet_id", (req, res) => {
  const pet_id = req.params.pet_id;

  const sqlQuery = "UPDATE pets SET isArchived = 1 WHERE pet_id = ?";
  db.query(sqlQuery, pet_id, (err, result) => {
    console.log("Archived pets");
    if (err == null) {
      res.send({ message: "Successfully Deleted" });
    } else {
      console.log(err);
    }
  });
});

app.put("/pets/update/:pet_id", (req, res) => {
  const pet_id = req.params.pet_id;
  const petName = req.body.pet_name;
  const typeOfPet = req.body.type_of_pet;
  const breedOfPet = req.body.breed_of_pet;
  const gender = req.body.gender;
  const birthDay = req.body.birth_day;
  const imageUrl = req.body.pet_picture;
  // console.log(petName);
  // console.log(typeOfPet);
  // console.log(breedOfPet);
  // console.log(gender);
  // console.log(birthDay);
  const sqlQuery =
    "UPDATE pets SET pet_name = ?,type_of_pet = ?,breed_of_pet = ?,gender = ?,birth_day = ?  WHERE pet_id = ?";
  db.query(
    sqlQuery,
    [petName, typeOfPet, breedOfPet, gender, birthDay, pet_id],
    (err, result) => {
      if (err == null) {
        res.send("Ok");
      } else {
        console.log(err);
      }
    }
  );
});

app.get("/pets/length/:vet_admin_id", (req, res) => {
  const vet_admin_id = req.params.vet_admin_id;
  const sqlQuery = "SELECT * FROM appointment WHERE vet_admin_id = ?";
  db.query(sqlQuery, vet_admin_id, (err, result) => {
    // console.log(result.length);
    // console.log(vet_admin_id.substring(1));
    // console.log(result);
    res.send({
      pets: result.length,
    });
  });
});

app.get("/pets/vaccine/:pet_id", (req, res) => {
  const pet_id = req.params.pet_id;
  const sqlQuery =
    "SELECT * FROM immunization_history JOIN appointment ON immunization_history.appointment_id = appointment.appointment_id JOIN services ON services.service_id= appointment.service_id JOIN vet_clinic ON vet_clinic.vetid = services.vetid WHERE appointment.pet_id = ? AND appointment_status= 'Done' AND services.category = 'Vaccination'";

  db.query(sqlQuery, pet_id, (err, result) => {
    // console.log(result.length);
    // console.log(pet_id);
    // console.log(result);
    res.send(result);
  });
});

//API pet vaccine insertion
app.post("/pets/vaccination/record/:pet_id", (req, res) => {
  const pet_id = req.params.pet_id;
  const appointment_id = req.body.appointment_id;
  const vaccineName = req.body.vaccineName;
  const weight = req.body.weight;
  const against = req.body.againsts;
  const manufacturer = req.body.manufacturer;
  const vaccineNumber = req.body.vaccineNumber;
  const prescrip = req.body.prescription;

  const sqlQuery =
    "INSERT INTO immunization_history (pet_id,pet_weight,vaccine_name,againts,vaccine_number,manufacturer,appointment_id,prescription) VALUES (?,?,?,?,?,?,?,?)";
  db.query(
    sqlQuery,
    [
      pet_id,
      weight,
      vaccineName,
      against,
      vaccineNumber,
      manufacturer,
      appointment_id,
      prescrip,
    ],
    (err, result) => {
      if (err == null) {
        res.send({
          response: "success",
        });
      } else {
        console.log(err);
      }
    }
  );
});


//API pet consultation insertion
app.post("/pets/consultation/records/:pet_id", (req, res) => {
  const pet_id = req.params.pet_id;
  const appointment_id = req.body.appointment_id;
  const service_id = req.body.service_id;
  const vetid = req.body.vetid;
  const consultationType = req.body.consultationType;
  console.log(pet_id);
  const sqlQuery =
    "INSERT INTO consultation (vetid,pet_id,appointment_id,service_id,consultation_type) VALUES (?,?,?,?,?)";
  db.query(
    sqlQuery,
    [
      vetid,
      pet_id,
      appointment_id,
      service_id,
      consultationType
    ],
    (err, result) => {
      if (err == null) {
        res.send({
          response: "success",
        });
      } else {
        console.log(err);
      }
    }
  );
});


//API pet medical history
app.post("/pets/medicalhistory/record/:pet_id", (req, res) => {
  const pet_id = req.params.pet_id;
  const appointment_id = req.body.appointment_id;
  const service_id = req.body.service_id;
  const vetid = req.body.vetid;
  console.log(vetid);
  const sqlQuery =
    "INSERT INTO medical_history (service_id,pet_id,vetid,appointment_id) VALUES (?,?,?,?)";
  db.query(
    sqlQuery,
    [
      service_id,
      pet_id,
      vetid,
      appointment_id,
    ],
    (err, result) => {
      if (err == null) {
        res.send({
          response: "success",
        });
      } else {
        console.log(err);
      }
    }
  );
});

//---------------------------------------------------------------Get Verified & Pending, Add, Delete, Update, Approved Vet Clinic----------------------------------------//

//this api is for vet clinic
//api for verified vet clinic
app.get("/vetclinic/verified", (req, res) => {
  const sqlQuery =
    "SELECT * FROM vet_clinic WHERE vet_status = 'Verified' AND isArchived = 'False'";
  db.query(sqlQuery, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//api for verified vet clinic for system admin
app.get("/vet-details/:email", (req, res) => {
  const email = req.params.email;
  const sqlQuery = "SELECT * FROM vet_clinic WHERE email = ?";
  db.query(sqlQuery, email, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//fuunction for verified vet clinic near pet owners
function getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
  var R = 6371; // Radius of the earth in km
  var dLat = deg2rad(lat2 - lat1); // deg2rad below
  var dLon = deg2rad(lon2 - lon1);
  var a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos(deg2rad(lat1)) *
    Math.cos(deg2rad(lat2)) *
    Math.sin(dLon / 2) *
    Math.sin(dLon / 2);
  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  var d = R * c; // Distance in km
  return Math.round(d * 10) / 10;
}

function deg2rad(deg) {
  return deg * (Math.PI / 180);
}
//api for verified vet clinic near pet owners
app.post("/vetclinic/verified/suggestion", (req, res) => {
  const lon = req.body.longitude;
  const lat = req.body.latitude;

  var suggestedVet = [];
  console.log(lon + " " + lat);
  const sqlQuery = "SELECT * FROM vet_clinic WHERE vet_status = 'Verified'";
  db.query(sqlQuery, (err, result) => {
    if (result.length > 0) {
      for (var i = 0; i < result.length; i++) {
        var temp = getDistanceFromLatLonInKm(
          lat,
          lon,
          result[i].Latitude,
          result[i].longitude
        );
        console.log(temp);
        if (temp < 2) {
          result[i].distance = temp;
          suggestedVet.push(result[i]);
        }
      }
    }
    console.log(suggestedVet);
    res.send(suggestedVet);
  });
});

//api for pending vet clinic
app.get("/vetclinic/pending", (req, res) => {
  const sqlQuery = "SELECT * FROM vet_clinic WHERE vet_status = 'Pending'";
  db.query(sqlQuery, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//api for resubmit vet clinic
app.get("/vetclinic/resubmit", (req, res) => {
  const sqlQuery = "SELECT * FROM vet_clinic WHERE vet_status = 'Invalid'";
  db.query(sqlQuery, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//api for resubmit vet clinic
app.get("/vetclinic/unverified", (req, res) => {
  const sqlQuery = "SELECT * FROM vet_clinic WHERE vet_status = 'Unverified'";
  db.query(sqlQuery, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//api for finding vet clinic
app.get("/vetclinic/verified/:vetid", (req, res) => {
  const vet_admin_id = req.params.vetid;
  // console.log(vet_admin_id);
  const sqlQuery =
    "SELECT * FROM vet_clinic WHERE vet_status = 'Verified' AND vetid = ?";
  db.query(sqlQuery, vet_admin_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//api for finding vet clinic in appointment
app.get("/vetclinic/verified/appointment/:vetid", (req, res) => {
  const vet_admin_id = req.params.vetid;
  // console.log(vet_admin_id);
  const sqlQuery =
    "SELECT * FROM vet_clinic WHERE vet_status = 'Verified' AND vetid = ?";
  db.query(sqlQuery, vet_admin_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

app.post("/vetclinic/insert", (req, res) => {
  const email = req.body.email;
  const password = req.body.password;
  const name = req.body.name;
  const lat = req.body.latitude;
  const lon = req.body.longitude;

  bcrypt.hash(password, saltRounds, (err, hash) => {
    bcrypt.hash(name, saltRounds, (err, hashId) => {
      const sqlQuery =
        "INSERT INTO vet_clinic (email,password,vet_name,vet_status,vetid,isOnline,longitude,Latitude) VALUES (?,?,?,?,?,?,?,?)";
      db.query(
        sqlQuery,
        [
          email,
          hash,
          name,
          "Unverified",
          hashId.replace("/", "5"),
          0,
          lon,
          lat,
        ],
        (err, result) => {
          if (err !== null) {
            console.log(err);
          } else {
            db.query(
              "INSERT INTO user_role (email,userrole) VALUES (?,?)",
              [email, 2],
              (err, result) => {
                if (err == null) {
                  console.log("no error registering");
                  res.send({
                    message: "Registered",
                  });
                } else {
                  console.log(err);
                }
              }
            );
          }
        }
      );
    });
  });
});

app.put("/vetclinic/verification/:vet_admin_id", (req, res) => {
  const vet_admin_id = req.params.vet_admin_id;
  const vet_permit = req.body.vet_permit;
  console.log(vet_permit);
  const sqlQuery =
    "UPDATE vet_clinic SET vet_permit = ? , vet_status = ? WHERE vet_admin_id = ?";
  db.query(sqlQuery, [vet_permit, "Pending", vet_admin_id], (err, result) => {
    console.log(result);
    res.send({
      message: "Update Successfully",
    });
  });
});

app.delete("/vetclinic/delete/:vet_admin_id", (req, res) => {
  const vet_admin_id = req.params.vet_admin_id;

  const sqlQuery = "DELETE FROM vet_clinic WHERE vet_admin_id = ?";
  db.query(sqlQuery, vet_admin_id, (err, result) => {
    console.log(result);
  });
});

//api of vet clinic if they need to update their vet clinic info
app.put("/vetclinic/update/:vet_admin_id", (req, res) => {
  const vet_admin_id = req.params.vet_admin_id;
  const email = req.body.email;
  const vet_name = req.body.vet_name;
  const vet_address = req.body.vet_address;
  const vet_contact_number = req.body.vet_contact_number;
  const oldnumber = req.body.oldnumber;
  // console.log(oldnumber);
  const sqlQuery = `UPDATE vet_clinic SET email = ?, vet_name = ? ,vet_address = ?,vet_contact_number = ? WHERE	vet_admin_id = ?`;
  db.query(
    sqlQuery,
    [email, vet_name, vet_address, vet_contact_number, vet_admin_id],
    (err, result) => {
      if (err == null) {
        db.query(
          "UPDATE user_role SET email = ? , phone_number = ? WHERE email = ? AND phone_number = ?",
          [email, vet_contact_number, email, oldnumber],
          (err, result) => {
            if (err == null) {
              res.send({ message: "Update Successfully" });
              // console.log("Update Successfully");
            } else {
              console.log(err);
            }
          }
        );
      } else {
        console.log(err);
        // res.sendStatus(400).send('Bad');
      }
    }
  );
});

//api of vet staff if they need to update their vet staff info
app.put("/staff/update/:vet_staff_id", (req, res) => {
  const vet_staff_id = req.params.vet_staff_id;
  const email = req.body.email;
  const vet_fname = req.body.vetFname;
  const vet_mname = req.body.vetMname;
  const vet_lname = req.body.vetLname;
  const vet_contact_number = req.body.vet_contact_number;
  const oldnumber = req.body.oldnumber;
  // console.log(oldnumber);
  const sqlQuery = `UPDATE vet_staff SET vet_staff_email = ?, vet_staff_fname = ? , vet_staff_lname = ?, vet_staff_mname = ?,vet_staff_contactNumber = ? WHERE	vet_staff_id = ?`;
  db.query(
    sqlQuery,
    [email, vet_fname, vet_lname, vet_mname, vet_contact_number, vet_staff_id],
    (err, result) => {
      if (err == null) {
        db.query(
          "UPDATE user_role SET email = ? , phone_number = ? WHERE email = ? AND phone_number = ?",
          [email, vet_contact_number, email, oldnumber],
          (err, result) => {
            if (err == null) {
              res.send({ message: "Update Successfully" });
              // console.log("Update Successfully");
            } else {
              console.log(err);
            }
          }
        );
      } else {
        console.log(err);
        // res.sendStatus(400).send('Bad');
      }
    }
  );
});

//api of vet staff if they need to update their vet staff info
app.put("/doc/update/:vet_doc_id", (req, res) => {
  const vet_doc_id = req.params.vet_doc_id;
  const email = req.body.email;
  const vet_fname = req.body.vetFname;
  const vet_mname = req.body.vetMname;
  const vet_lname = req.body.vetLname;
  const vet_contact_number = req.body.vet_contact_number;
  const oldnumber = req.body.oldnumber;
  // console.log(oldnumber);
  const sqlQuery = `UPDATE vet_doctors SET vet_doc_email = ?, vet_doc_fname = ? , vet_doc_lname = ?, vet_doc_mname = ?,vet_doc_contactNumber = ? WHERE	vet_doc_id = ?`;
  db.query(
    sqlQuery,
    [email, vet_fname, vet_lname, vet_mname, vet_contact_number, vet_doc_id],
    (err, result) => {
      if (err == null) {
        db.query(
          "UPDATE user_role SET email = ? , phone_number = ? WHERE email = ? AND phone_number = ?",
          [email, vet_contact_number, email, oldnumber],
          (err, result) => {
            if (err == null) {
              res.send({ message: "Update Successfully" });
              // console.log("Update Successfully");
            } else {
              console.log(err);
            }
          }
        );
      } else {
        console.log(err);
        // res.sendStatus(400).send('Bad');
      }
    }
  );
});

//Update Vet Clinic Hours Only
app.put("/vetclinic/schedule/update/:vet_admin_id", (req, res) => {
  const vet_admin_id = req.params.vet_admin_id;
  const scheduleMonday = req.body.scheduleMonday;
  const scheduleTuesday = req.body.scheduleTuesday;
  const scheduleWednesday = req.body.scheduleWednesday;
  const scheduleThursday = req.body.scheduleThursday;
  const scheduleFriday = req.body.scheduleFriday;
  const scheduleSaturday = req.body.scheduleSaturday;
  const scheduleSunday = req.body.scheduleSunday;

  const sqlQuery = `UPDATE vet_clinic SET scheduleMonday = ? , scheduleTuesday = ?, scheduleWednesday = ? , scheduleThursday = ?,
    scheduleFriday = ? , scheduleSaturday = ? ,scheduleSunday = ?
    WHERE	vet_admin_id = ?`;
  db.query(
    sqlQuery,
    [
      scheduleMonday,
      scheduleTuesday,
      scheduleWednesday,
      scheduleThursday,
      scheduleFriday,
      scheduleSaturday,
      scheduleSunday,
      vet_admin_id,
    ],
    (err, result) => {
      if (err === null) {
        res.send({ message: "Update Successfully" });
      } else {
        console.log(err);
        // res.sendStatus(400).send('Bad');
      }
    }
  );
});

//Update Vet Clinic Offers Only
app.put("/vetclinic/offers/update/:vet_admin_id", (req, res) => {
  const vet_admin_id = req.params.vet_admin_id;
  const enableProduct = req.body.enableProduct;
  const enablePharmacy = req.body.enablePharmacy;
  const enableServices = req.body.enableServices;
  const enableConsultation = req.body.enableConsultation;
  const enableExamination = req.body.enableExamination;
  const enableVaccination = req.body.enableVaccination;
  const enableGrooming = req.body.enableGrooming;
  const enablePreventiveControls = req.body.enablePreventiveControls;
  const enableConsultationPhysical = req.body.enableConsultationPhysical;
  const enableOnlineConsultation = req.body.enableOnlineConsultation;

  const sqlQuery = `UPDATE vet_clinic SET enableProduct = ? , enablePharmacy = ?,  enableServices = ? , 
  enableExamination = ? , enableVaccination = ? , enableGrooming = ? ,enablePreventiveControls = ? ,  enableConsultation = ?
    WHERE	vet_admin_id = ?`;
  db.query(
    sqlQuery,
    [
      enableProduct,
      enablePharmacy,
      enableServices,
      enableExamination,
      enableVaccination,
      enableGrooming,
      enablePreventiveControls,
      enableConsultation,
      vet_admin_id,
    ],
    (err, result) => {
      if (err === null) {
        res.send({ message: "Update Successfully" });
      } else {
        console.log(err);
        // res.sendStatus(400).send('Bad');
      }
    }
  );
});

// api update profile picture of vet clinic
app.post("/vetclinic/update/profile", (req, res) => {
  const imageUrl = req.body.imageUrl;
  const vetid = req.body.vetid;

  db.query(
    "UPDATE vet_clinic SET vet_picture = ? WHERE vetid = ?",
    [imageUrl, vetid],
    (err, result) => {
      if (err === null) {
        res.send({ message: "Update Successfully" });
      } else {
        console.log(err);
      }
    }
  );
});

//api of system admin if they need to approved a vet clinic
app.put("/vetclinic/confirm/:vet_admin_id", (req, res) => {
  const vet_admin_id = req.params.vet_admin_id;

  const sqlQuery = "UPDATE vet_clinic SET vet_status = ? WHERE	vet_admin_id = ?";
  db.query(sqlQuery, ["Verified", vet_admin_id], (err, result) => {
    console.log(err);
  });
});

//api of system admin if they need to reject a vet clinic
app.put("/vetclinic/invalid/:vet_admin_id", (req, res) => {
  const vet_admin_id = req.params.vet_admin_id;

  const sqlQuery = "UPDATE vet_clinic SET vet_status = ? WHERE	vet_admin_id = ?";
  db.query(sqlQuery, ["Invalid", vet_admin_id], (err, result) => {
    console.log(err);
  });
});

//api of system admin if they need to delete a vet clinic
app.put("/vetclinic/remove/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(vetid);
  const sqlQuery = "UPDATE vet_clinic SET isArchived = 1 WHERE email= ?";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(err);
    if (err == null) {
      res.send({ message: "Successfully removed" });
    } else {
      console.log(err);
    }
  });
});

//authenticate Vet upon uploading permit
app.get("/vet/uploads", (req, res) => {
  //Authenticate

  const email = req.query.email;
  console.log(email);
  db.query("SELECT * FROM user_role WHERE email = ?", email, (err, result) => {
    console.log(result);
    if (err) {
      res.send({ err: err });
    }

    if (result[0].userrole == 2) {
      db.query(
        "SELECT * FROM vet_clinic WHERE email = ?",
        email,
        (err, result) => {
          if (err) {
            res.send({ err: err });
          }
          const user = { result };
          // console.log(user)
          const accessToken = generateAccessToken(user);
          const refreshToken = jwt.sign(user, process.env.REFRESH_TOKEN_SECRET);
          refreshTokens.push(refreshToken);
          let u = JSON.parse(JSON.stringify(user));
          // console.log(u.result[0].name)
          res.send({
            accessToken: accessToken,
            refreshToken: refreshToken,
            message: "Correct",
            role: 2,
            vetStatus: result[0].vet_status,
            id: result[0].vet_admin_id,
          });
        }
      );
    }

    if (result[0].userrole == 4) {
      db.query(
        "SELECT * FROM vet_doctors WHERE vet_doc_email = ?",
        email,
        (err, result) => {
          if (err) {
            res.send({ err: err });
          }
          const user = { result };
          // console.log(user)
          const accessToken = generateAccessToken(user);
          const refreshToken = jwt.sign(user, process.env.REFRESH_TOKEN_SECRET);
          refreshTokens.push(refreshToken);
          let u = JSON.parse(JSON.stringify(user));
          // console.log(u.result[0].name)
          res.send({
            accessToken: accessToken,
            refreshToken: refreshToken,
            message: "Correct",
            role: 4,
            // vetStatus: result[0].vet_status,
            id: result[0].vet_doc_id,
          });
        }
      );
    }

    if (result[0].userrole == 5) {
      db.query(
        "SELECT * FROM vet_staff WHERE vet_staff_email = ?",
        email,
        (err, result) => {
          if (err) {
            res.send({ err: err });
          }
          const user = { result };
          // console.log(user)
          const accessToken = generateAccessToken(user);
          const refreshToken = jwt.sign(user, process.env.REFRESH_TOKEN_SECRET);
          refreshTokens.push(refreshToken);
          let u = JSON.parse(JSON.stringify(user));
          // console.log(u.result[0].name)
          res.send({
            accessToken: accessToken,
            refreshToken: refreshToken,
            message: "Correct",
            role: 5,
            // vetStatus: result[0].vet_status,
            id: result[0].vet_staff_id,
          });
        }
      );
    }
  });
});

//authenticate pet owner upon uploading updatimg credentials
app.get("/petOwner/update/credentials", (req, res) => {
  //Authenticate
  console.log("here");
  const email = req.query.email;

  db.query("SELECT * FROM user_role WHERE email = ?", email, (err, result) => {
    if (err) {
      res.send({ err: err });
    }

    if (result[0].userrole == 1) {
      db.query(
        "SELECT * FROM pet_owners WHERE email = ?",
        email,
        (err, result) => {
          if (err) {
            res.send({ err: err });
          }
          const user = { result };
          // console.log(user);
          const accessToken = generateAccessToken(user);
          const refreshToken = jwt.sign(user, process.env.REFRESH_TOKEN_SECRET);
          refreshTokens.push(refreshToken);
          // let u = JSON.parse(JSON.stringify(user));
          // console.log(u.result[0].name)
          res.send({
            accessToken: accessToken,
            refreshToken: refreshToken,
            message: "Correct",
            role: 1,
            id: result[0].pet_owner_id,
          });
        }
      );
    }
  });
});

//password mobile
app.put("/petowner/update/password/:petowner_id", (req, res) => {
  const petowner_id = req.params.petowner_id;
  const updatePetOwnerPassword = req.body.updatePetOwnerPassword;

  bcrypt.hash(updatePetOwnerPassword, saltRounds, (err, hash) => {
    const sqlQuery =
      "UPDATE pet_owners SET password = ?  WHERE pet_owner_id = ?";
    db.query(sqlQuery, [hash, petowner_id], (err, result) => {
      if (err === null) {
        res.send({ message: "Correct" });
      } else {
        console.log(err);
      }
    });
  });
});

//credentials mobile
app.put("/petowner/update/:petowner_id", (req, res) => {
  const petowner_id = req.params.petowner_id;
  const updatePetOwnerName = req.body.updatePetOwnerName;
  const updatePetOwnerEmail = req.body.updatePetOwnerEmail;
  const updatePetOwnerContactNumber = req.body.updatePetOwnerContactNumber;
  const updatePetOwnerAddress = req.body.updatePetOwnerAddress;

  const sqlQuery =
    "UPDATE pet_owners SET email = ?,name = ?,contact_number = ?,address = ? WHERE pet_owner_id = ?";
  db.query(
    sqlQuery,
    [
      updatePetOwnerEmail,
      updatePetOwnerName,
      updatePetOwnerContactNumber,
      updatePetOwnerAddress,
      petowner_id,
    ],
    (err, result) => {
      if (err === null) {
        res.send({ message: "Correct" });
      } else {
        console.log(err);
      }
    }
  );
});

app.delete("/logout", (req, res) => {
  refreshTokens = refreshTokens.filter((token) => token !== req.body.token);
  res.sendStatus(204);
});

// logout vet clinic admin
app.put("/logout/user/vetclinic/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  db.query(
    "UPDATE vet_clinic SET isOnline = 0 WHERE vetid = ?",
    vetid,
    (err, result) => {
      if (err == null) {
        res.send({ message: "Success" });
      } else {
        console.log("Logout Error");
      }
    }
  );
});

// logout veterinarian
app.put("/logout/user/doc/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  console.log(vetid);
  db.query(
    "UPDATE vet_doctors SET isOnline = 0 WHERE vetid = ?",
    vetid,
    (err, result) => {
      if (err == null) {
        res.send({ message: "Success" });
      } else {
        console.log("Logout Error");
      }
    }
  );
});

// logout vet staff
app.put("/logout/user/staff/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  console.log(vetid);
  db.query(
    "UPDATE vet_staff SET isOnline = 0 WHERE vetid = ?",
    vetid,
    (err, result) => {
      if (err == null) {
        res.send({ message: "Success" });
      } else {
        console.log("Logout Error");
      }
    }
  );
});

// logout unverified vet clinic admin
app.put("/logout/user/vetclinic/unverified/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  console.log("here");
  db.query(
    "UPDATE vet_clinic SET isOnline = 0 WHERE vetid = ?",
    vetid,
    (err, result) => {
      if (err == null) {
        res.send({ message: "Success" });
      } else {
        console.log("Logout Error");
      }
    }
  );
});

app.post("/register/petowner", (req, res) => {
  const email = req.body.email;
  const password = req.body.password;
  const name = req.body.name;
  const address = req.body.address;
  const contactNumber = req.body.contactNumber;
  const profile_petowner = req.body.profile_petowner;
  // const imageUrl = req.body.profile_petowner;
  // console.log(name);

  // console.log(uploadpetowner.single(profile_petowner));
  //   const imageUrl = `http://localhost:3001/profile/petowner/${req.file.filename}`;

  db.query(
    "INSERT INTO user_role (email,userrole) VALUES (?,?)",
    [email, 1],
    (err, result) => {
      console.log("no error registering");
    }
  );

  bcrypt.hash(password, saltRounds, (err, hash) => {
    if (err) {
      console.log(err);
    }

    db.query(
      "INSERT INTO pet_owners (email,password,name,address,contact_number,profilePicture) VALUES (?,?,?,?,?,?)",
      [email, hash, name, address, contactNumber, profile_petowner],
      (err, result) => {
        console.log(err);
        res.send({
          message: "Registered",
        });
      }
    );
  });
});

// api for inserting vet clinic information
app.post("/vetclinic/credentials/insert", (req, res) => {
  const contactNumber = req.body.contactNumber;
  const address = req.body.address;
  const vetid = req.body.vetid;
  const email = req.body.email;

  db.query(
    "UPDATE vet_clinic SET vet_contact_number = ? , vet_address = ?  WHERE vetid = ?",
    [contactNumber, address, vetid],
    (err, result) => {
      if (err == null) {
        db.query(
          "UPDATE user_role SET phone_number = ?  WHERE email = ?",
          [contactNumber, email],
          (err, result) => {
            if (err == null) {
              res.send("Success");
            } else {
              console.log(err);
            }
          }
        );
      } else {
        console.log(err);
      }
    }
  );
});

// api for updating subscription
app.put("/vetclinic/subscribe/:vetid/:subscriptionType", (req, res) => {
  const vetid = req.params.vetid;
  const subscriptionType = req.params.subscriptionType;

  db.query(
    "UPDATE vet_clinic SET subscriptionType = ? WHERE vetid = ?",
    [subscriptionType, vetid],
    (err, result) => {
      if (err == null) {
        res.send("Success");
      } else {
        console.log(err);
      }
    }
  );
});

// api for reset subscription
app.put("/vetclinic/reset/:vetid", (req, res) => {
  const vetid = req.params.vetid;

  db.query(
    "UPDATE vet_clinic SET subscriptionType = NULL WHERE vetid = ?",
    [vetid],
    (err, result) => {
      if (err == null) {
        res.send("Success");
      } else {
        console.log(err);
      }
    }
  );
});

//---------------------------------------------------------------Get, Add, Delete, and Update Products----------------------------------------//

//this api is for products

app.get("/product", (req, res) => {
  const sqlQuery = "SELECT * FROM products";
  db.query(sqlQuery, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//this api is for products per vet clinic
app.get("/products/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(vet_admin_id);
  const sqlQuery = "SELECT * FROM products WHERE vetid = ?";
  db.query(sqlQuery, vetid, (err, result) => {
    console.log(result);
    res.send(result);
  });
});

//this api is for products count per vet clinic
app.get("/products/count/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(vet_admin_id);
  const sqlQuery = "SELECT * FROM products WHERE vetid = ?";
  db.query(sqlQuery, vetid, (err, result) => {
    console.log(result);
    res.send(result);
  });
});

app.post("/product/insert/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  const insertProductImage = req.body.insertProductImage;
  const insertProductName = req.body.insertProductName;
  const insertProductDescription = req.body.insertProductDescription;
  const insertProductQuantity = req.body.insertProductQuantity;
  const insertProductPrice = req.body.insertProductPrice;
  const id = Math.floor(Math.random() * 100000000);
  const insertProductCategory = req.body.insertProductCategory;
  const insertProductPetType = req.body.insertProductPetType;

  const sqlQuery =
    "INSERT INTO products (product_id,product_name,product_desc,vetid,quantity,price,product_image,category,pet_type) VALUES (?,?,?,?,?,?,?,?,?)";
  db.query(
    sqlQuery,
    [
      id,
      insertProductName,
      insertProductDescription,
      vetid,
      insertProductQuantity,
      insertProductPrice,
      insertProductImage,
      insertProductCategory,
      insertProductPetType,
    ],
    (err, result) => {
      if (err === null) {
        res.send({ message: "Success" });
      } else {
        console.log(err);
      }
    }
  );
});

app.post("/product/delete/:product_id", (req, res) => {
  const product_id = req.params.product_id;
  const vetid = req.body.vet_id;

  // console.log(vetid);
  const sqlQuery = "DELETE FROM products WHERE product_id = ? AND vetid = ?";
  db.query(sqlQuery, [product_id, vetid], (err, result) => {
    console.log(result);
    if (err == null) {
      res.send({ message: "Success" });
    } else {
      console.log("Error deleting product");
    }
  });
});

app.put("/product/update/:productUpdateId", (req, res) => {
  const product_id = req.params.productUpdateId;
  const product_name = req.body.updateProductName;
  const product_description = req.body.updateProductDescription;
  const product_quantity = req.body.updateProductQuantity;
  const product_price = req.body.updateProductPrice;
  const product_image = req.body.updateProductImage;
  const product_categ = req.body.updateProductCategory;
  const product_petType = req.body.updateProductType;

  console.log("updateeeee products");
  // console.log(vetid);
  // console.log(product_name);
  // console.log(product_description);
  // console.log(product_price);
  // console.log(product_quantity);

  const sqlQuery =
    "UPDATE products SET product_name = ?,product_desc = ?,quantity = ?,price = ?, product_image = ?, category = ?, pet_type = ? WHERE product_id = ?";
  db.query(
    sqlQuery,
    [
      product_name,
      product_description,
      product_quantity,
      product_price,
      product_image,
      product_categ,
      product_petType,
      product_id,
    ],
    (err, result) => {
      if (err == null) {
        res.send({ message: "Success" });
      } else {
        console.log("Error updating product");
      }
    }
  );
});

// Stock In
app.post("/product/update/stockin/:productUpdateId", (req, res) => {
  const product_id = req.params.productUpdateId;
  const vetid = req.body.vetid;
  const quantity = req.body.quantity;

  const sqlQuery =
    "INSERT INTO stock_in (vetid,product_id,stockin_quantity) VALUES (?,?,?)";
  db.query(sqlQuery, [vetid, product_id, quantity], (err, result) => {
    console.log(err);
  });
});

//Stock Used
app.post("/product/update/stockused/:productUpdateId", (req, res) => {
  const product_id = req.params.productUpdateId;
  const vetid = req.body.vetid;
  const quantity = req.body.quantity;

  const sqlQuery =
    "INSERT INTO stock_used (vetid,product_id,stockused_quantity) VALUES (?,?,?)";
  db.query(sqlQuery, [vetid, product_id, quantity], (err, result) => {
    console.log(err);
  });
});

//Reservation API
app.post("/products/reserve/:productId", (req, res) => {
  const order_id = req.params.orderId;
  const vetid = req.body.vetid;
  const pet_owner_id = req.body.pet_owner_id;
  const quantity = req.body.quantity;
  const product_id = req.body.productId;

  var date = new Date();
  date.setHours(date.getHours() + 8);

  // now you can get the string
  var isodate = date.toISOString();
  // console.log(product_id);
  const sqlQuery =
    "INSERT INTO reservation (pet_owner_id,vetid,reservation_status, date_reserve,order_id) VALUES (?,?,?,?,?)";
  db.query(
    sqlQuery,
    [pet_owner_id, vetid, "Pending", isodate, order_id],
    (err, result) => {
      const arrProducts = [];
      if (err == null) {
        for (var i = 0; i < arrProducts.length; i++) {
          const sqlQuery =
            "INSERT INTO reservation_products(order_id,product_id,quantity) VALUES (?,?,?)";

          db.query(
            sqlQuery,
            [order_id, product_id, quantity],
            (err, result) => {
              res.send("Success");
            }
          );
        }
      }
    }
  );

  // var product = [];
  // const selectProduct = "SELECT * FROM products WHERE product_id = ?";
  // db.query(selectProduct, product_id, (err, result) => {
  //   product.push(JSON.parse(JSON.stringify(result[0])));
  //   // console.log(product[0].quantity);
  //   var deduced = product[0].quantity - quantity;
  //   // console.log(deduced);

  //   const updateProduct =
  //     "UPDATE products SET quantity = ? WHERE product_id = ?";
  //   db.query(updateProduct, [deduced, product_id], (err, result) => {
  //     if (err == null) {
  //       console.log(err);
  //     } else {
  //       res.send("success");
  //     }
  //   });
  // });
});

//this api is for expired reservation products per vet clinic
app.put("/expiration/reservation/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(vetid);
  const sqlQuery =
    "UPDATE reservation SET reservation_status = 'Expired' , date_accomplished = CURRENT_TIMESTAMP WHERE date_reserve < DATE_ADD(CURRENT_DATE, INTERVAL '00:00' HOUR_MINUTE) AND vetid = ? AND reservation_status != 'Expired' ";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//this api is for reservation products per vet clinic
app.get("/pending/reservation/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(pet_owner_id);
  const sqlQuery =
    "SELECT * FROM vet_clinic JOIN products ON vet_clinic.vetid = products.vetid JOIN reservation ON reservation.product_id= products.product_id JOIN pet_owners ON pet_owners.pet_owner_id = reservation.pet_owner_id WHERE vet_clinic.vetid = ? AND reservation.reservation_status='Pending' ORDER BY reservation.reserve_id DESC";
  db.query(sqlQuery, vetid, (err, result) => {
    console.log(result);
    res.send(result);
  });
});

//this api is for reservation history products per vet clinic
app.get("/history/reservation/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(pet_owner_id);
  const sqlQuery =
    "SELECT * FROM reservation JOIN pet_owners ON reservation.pet_owner_id = pet_owners.pet_owner_id WHERE reservation.vetid = ? AND reservation.reservation_status IN ('Purchased', 'Expired') ORDER BY reservation.reserve_id DESC";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//this api is for reservation products per pet owner
app.get("/reservation/:pet_owner_id", (req, res) => {
  const pet_owner_id = req.params.pet_owner_id;
  // console.log(pet_owner_id);
  const sqlQuery =
    "SELECT * FROM vet_clinic JOIN products ON vet_clinic.vetid = products.vetid JOIN reservation ON reservation.product_id= products.product_id JOIN pet_owners ON pet_owners.pet_owner_id = reservation.pet_owner_id WHERE reservation.pet_owner_id = ? AND reservation.reservation_status='Pending' ORDER BY reservation.date_reserve ASC";
  db.query(sqlQuery, pet_owner_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//this api is for reservation history products per pet owner
app.get("/reservation/history/:pet_owner_id", (req, res) => {
  const pet_owner_id = req.params.pet_owner_id;
  // console.log(pet_owner_id);
  const sqlQuery =
    "SELECT * FROM vet_clinic JOIN products ON vet_clinic.vetid = products.vetid JOIN reservation ON reservation.product_id= products.product_id JOIN pet_owners ON pet_owners.pet_owner_id = reservation.pet_owner_id WHERE reservation.pet_owner_id = ? AND reservation.reservation_status='Done' ORDER BY reservation.reserve_id DESC";
  db.query(sqlQuery, pet_owner_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

// Stoked decreased after confirmation
app.put("/stockUsed/decrease/product/:product_id", (req, res) => {
  const product_id = req.params.product_id;
  const stock = req.body.decreaseStock;

  db.query(
    "UPDATE products SET quantity = ? WHERE product_id = ?",
    [stock, product_id],
    (err, result) => {
      res.send("Success");
    }
  );
});

// update product reservation
app.put("/confirm/product/reservation/:reservationId", (req, res) => {
  const reservation_id = req.params.reservationId;
  var date = new Date();
  date.setHours(date.getHours() + 8);
  var isodate = date.toISOString();
  // console.log(isodate);
  const sqlQuery =
    "UPDATE reservation SET reservation_status = ? , date_accomplished = ? WHERE reserve_id = ?";
  db.query(sqlQuery, ["Done", isodate, reservation_id], (err, result) => {
    if (err == null) {
      res.send("Success");
    } else {
      console.log(err);
    }
  });
});

// sort product type of pet & category
app.post("/vetclinic/product/filtered", (req, res) => {
  const typeOfPet = req.body.typeOfPet;
  const category = req.body.category;
  const vetid = req.body.vetid;
  // console.log(vetid);
  db.query(
    "SELECT * FROM products WHERE pet_type = ? AND category = ? AND vetid = ? ORDER BY product_name ASC",
    [typeOfPet, category, vetid],
    (err, result) => {
      console.log(result);
      res.send(result);
    }
  );
});

// sort product type of pet
app.post("/vetclinic/product/filtered/typeOfPet", (req, res) => {
  const typeOfPet = req.body.typeOfPet;
  const vetid = req.body.vetid;
  db.query(
    "SELECT * FROM products WHERE pet_type = ? AND vetid = ? ORDER BY product_name ASC",
    [typeOfPet, vetid],
    (err, result) => {
      console.log(result);
      res.send(result);
    }
  );
});

// sort product  category
app.post("/vetclinic/product/filtered/category", (req, res) => {
  const category = req.body.category;
  const vetid = req.body.vetid;
  db.query(
    "SELECT * FROM products WHERE category = ? AND vetid = ? ORDER BY product_name ASC",
    [category, vetid],
    (err, result) => {
      console.log(result);
      res.send(result);
    }
  );
});

//---------------------------------------------------------------Get, Add, Delete, and Update Services-----------------------------------------//

//this api is for services

app.get("/services", (req, res) => {
  const sqlQuery = "SELECT * FROM services";
  db.query(sqlQuery, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//this api is for services

app.get("/services/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  const sqlQuery = "SELECT * FROM services WHERE vetid = ?";
  db.query(sqlQuery, vetid.substring(1), (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//this api is for consulation services

app.get("/consultation/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  const sqlQuery =
    "SELECT * FROM services WHERE vetid = ? AND category = 'Consultation'";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//this api is for consulation physical services

app.get("/consultation/physical/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  const sqlQuery =
    "SELECT * FROM services WHERE vetid = ? AND category = 'Consultation' AND service_name='Physical Consultation'";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//this api is for consulation virtual services

app.get("/consultation/virtual/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  const sqlQuery =
    "SELECT * FROM services WHERE vetid = ? AND category = 'Consultation' AND service_name='Online Consultation'";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//this api is for pet exam services

app.get("/petExamination/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  const sqlQuery =
    "SELECT * FROM services WHERE vetid = ? AND category = 'Pet Examination'";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//this api is for Pet Grooming services

app.get("/petGrooming/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  const sqlQuery =
    "SELECT * FROM services WHERE vetid = ? AND category = 'Pet Grooming'";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//this api is for Preventive Controls services

app.get("/preventiveControls/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  const sqlQuery =
    "SELECT * FROM services WHERE vetid = ? AND category = 'Preventive Controls'";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//this api is for vaccination services

app.get("/vaccine/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  const sqlQuery =
    "SELECT * FROM services WHERE vetid = ? AND category = 'Vaccination'";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//api for specific vet clinic
app.get("/services/details/info/:vet_admin_id", (req, res) => {
  const vet_admin_id = req.params.vet_admin_id;
  const id = vet_admin_id.split("&")[0];
  const category = vet_admin_id.split("&")[1];
  // console.log(category);
  const sqlQuery = "SELECT * FROM services WHERE vetid = ? AND category = ?";
  db.query(sqlQuery, [id.substring(1), category], (err, result) => {
    // console.log(result);
    res.send(result);
    // console.log(result);
  });
});

//api for specific service of vet clinic
app.get("/services/details/:serviceid", (req, res) => {
  const serviceid = req.params.serviceid;
  // console.log(serviceid.substring(1));
  const sqlQuery = "SELECT * FROM services WHERE service_id = ?";
  db.query(sqlQuery, serviceid.substring(1), (err, result) => {
    // console.log(result);
    res.send(result);
    // console.log(result);
  });
});

app.post("/services/insert/:vetid", (req, res) => {
  const serviceName = req.body.serviceName;
  const serviceDescription = req.body.serviceDescription;
  const vetid = req.params.vetid;
  const service_fee = req.body.service_fee;
  const category = req.body.category;
  // console.log(service_fee);
  const sqlQuery =
    "INSERT INTO services (service_name,service_description,category,service_fee,vetid) VALUES (?,?,?,?,?)";
  db.query(
    sqlQuery,
    [
      serviceName,
      serviceDescription,
      category,
      service_fee,
      vetid.substring(1),
    ],
    (err, result) => {
      console.log(err);

      if (err === null) {
        res.send({
          message: "Success",
        });
      }
    }
  );
});

app.delete("/service/delete/:service_id", (req, res) => {
  const service_id = req.params.service_id;

  const sqlQuery = "DELETE FROM services WHERE service_id = ?";
  db.query(sqlQuery, service_id.substring(1), (err, result) => {
    console.log(err);
    if (err == null) {
      res.send({
        message: "Success",
      });
    }
  });
});

app.put("/service/update/:service_id", (req, res) => {
  const service_id = req.params.service_id;
  const service_name = req.body.updateServiceName;
  const service_description = req.body.updateServiceDescription;
  const service_fee = req.body.updateServiceFee;
  const service_category = req.body.updateServiceCategory;
  // console.log(service_id + " " + service_name + " " + service_description);
  const sqlQuery =
    "UPDATE services SET service_name = ?,service_description = ? , category = ?,service_fee = ? WHERE service_id = ?";
  db.query(
    sqlQuery,
    [
      service_name,
      service_description,
      service_category,
      service_fee,
      service_id,
    ],
    (err, result) => {
      console.log(err);
      if (err === null) {
        res.send({
          message: "Success",
        });
      }
    }
  );
});

app.put("/reservation/cancel", (req, res) => {
  const reserve_id = req.body.id;
  const quantity = req.body.quantity;
  const product_id = req.body.product_id;
  // console.log(reserve_id);
  const sqlQuery =
    "UPDATE reservation SET reservation_status = 'Cancelled' WHERE reserve_id = ?";
  db.query(sqlQuery, reserve_id, (err, result) => {
    var product = [];
    const selectProduct = "SELECT * FROM products WHERE product_id = ?";
    db.query(selectProduct, product_id, (err, result) => {
      product.push(JSON.parse(JSON.stringify(result[0])));
      // console.log(product[0].quantity);
      var deduced = product[0].quantity + parseInt(quantity);
      // console.log(deduced);

      const updateProduct =
        "UPDATE products SET quantity = ? WHERE product_id = ?";
      db.query(updateProduct, [deduced, product_id], (err, result) => { });
    });

    console.log(err);
    res.send({ message: "Cancelled Reservation" });
  });
});

//this api is for expired pending appointments per vet clinic
app.put("/expiration/pending/appointment/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(vetid);
  const sqlQuery =
    "UPDATE appointment SET appointment_status = 'Expired' , date_accomplished = CURRENT_TIMESTAMP WHERE date_scheduled < CURRENT_DATE() AND vetid = ? AND appointment_status != 'Expired' AND appointment_status != 'Approved' AND appointment_status != 'Decline' AND appointment_status != 'Done' ";
  db.query(sqlQuery, vetid, (err, result) => {
    console.log(result);
    res.send(result);
  });
});

//-----------------------------------------------------------Get, Add, Delete, and Update Pharmacy---------------------------------------//

//this api is for pharmacy

app.get("/pharmacy", (req, res) => {
  const sqlQuery = "SELECT * FROM pharmacy";
  db.query(sqlQuery, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

app.get("/pharmacy/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  const sqlQuery = "SELECT * FROM pharmacy WHERE vetid = ? AND status= 1";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

app.post("/pharmacy/insert/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  const insertMedicineImage = req.body.insertMedicineImage;
  const insertMedicineName = req.body.insertMedicineName;
  const insertMedicineDescription = req.body.insertMedicineDescription;
  const insertMedId = Math.floor(Math.random() * 100000000);
  const insertMedicinePrice = req.body.insertMedicinePrice;
  const insertMedicineNumber = req.body.insertMedicineNumber;
  console.log("Medicineeeeeeeeeeeee");
  const sqlQuery =
    "INSERT INTO pharmacy (medicine_name,medicine_description,status,price,vetid,medicine_image,med_id,medicine_number) VALUES (?,?,?,?,?,?,?,?)";
  db.query(
    sqlQuery,
    [
      insertMedicineName,
      insertMedicineDescription,
      true,
      insertMedicinePrice,
      vetid,
      insertMedicineImage,
      insertMedId,
      insertMedicineNumber,
    ],
    (err, result) => {
      if (err == null) {
        res.send({ message: "Success" });
      } else {
        console.log(err);
      }
    }
  );
});

app.post("/pharmacy/delete/:medicine_id", (req, res) => {
  const medicine_id = req.params.medicine_id;
  const vetid = req.body.vetid;
  // console.log(medicine_id);
  // console.log(vetid);
  const sqlQuery = "DELETE FROM pharmacy WHERE med_id = ? AND vetid = ?";
  db.query(sqlQuery, [medicine_id, vetid], (err, result) => {
    if (err == null) {
      res.send({ message: "Success" });
    } else {
      console.log(err);
    }
  });
});

app.put("/pharmacy/update/:pharmacyUpdateId", (req, res) => {
  const medicine_id = req.params.pharmacyUpdateId;
  const vetid = req.body.vetid;
  const medicine_image = req.body.medicine_image;
  const medicine_name = req.body.medicine_name;
  const medicine_description = req.body.medicine_description;
  const medicine_price = req.body.medicine_price;
  const status = req.body.status;
  const medicine_number = req.body.medicine_number;

  // console.log(vetid);
  // console.log(medicine_image);
  // console.log(medicine_name);
  // console.log(medicine_description);
  // console.log(medicine_price);
  // console.log(status);

  const sqlQuery =
    "UPDATE pharmacy SET medicine_name = ?,medicine_description = ?,status = ? ,price = ?,medicine_image = ?, medicine_number = ?  WHERE med_id = ? AND vetid = ?";
  db.query(
    sqlQuery,
    [
      medicine_name,
      medicine_description,
      status,
      medicine_price,
      medicine_image,
      medicine_number,
      medicine_id,
      vetid,
    ],
    (err, result) => {
      if (err == null) {
        res.send({ message: "Success" });
      } else {
        console.log(err);
      }
    }
  );
});

//--------------------------------------------Get and Add History-------------------------------------------//

//this api is for History

//this api for history of system admin
app.get("/history", (req, res) => {
  const sqlQuery = "SELECT * FROM history";
  db.query(sqlQuery, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//this api for history of pet owner
app.get("/history/petowner/:petOwnerId", (req, res) => {
  const petOwnerId = req.params.petOwnerId;
  const sqlQuery = "SELECT * FROM history WHERE pet_owner_id = ?";
  db.query(sqlQuery, petOwnerId, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//this api for history of vet clinic
app.get("/history/vetclinic/:vetAdminId", (req, res) => {
  const vetAdminId = req.params.vetAdminId;
  // console.log(vetAdminId);
  const sqlQuery = "SELECT * FROM history WHERE vet_admin_id = ?";
  db.query(sqlQuery, vetAdminId, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//this api is for vet clinic
app.post("/history/vetclinic/insert/:vet_admin_id", (req, res) => {
  const pet_owner_id = req.body.pet_owner_id;
  const appointment_id = req.body.appointment_id;
  const date_and_time = new Date().getDate();

  const sqlQuery =
    "INSERT INTO history (type_of_transaction,pet_owner_id,appointment_id,date_and_time,remarks) VALUES (?,?,?,?,?)";
  db.query(
    sqlQuery,
    ["Appointment", pet_owner_id, appointment_id, date_and_time, "Done"],
    (err, result) => {
      console.log(err);
    }
  );
});

//------------------------------------------------dashboard get data system admin---------------------------------------//

//this api is for dashboard of system admin
app.get("/petowner/length", (req, res) => {
  const sqlQuery = "SELECT * FROM pet_owners WHERE isArchived = 0";
  db.query(sqlQuery, (err, result) => {
    // console.log(result.length);
    if (result.length > 0) {
      res.send({
        petOwners: result.length,
      });
    } else {
      res.send({
        petOwners: 0,
      });
    }
  });
});

app.get("/petowners/addpet", (req, res) => {
  const sqlQuery = "SELECT pet_owner_id,name FROM pet_owners";
  db.query(sqlQuery, (err, result) => {
    // console.log(result.length);
    res.send({
      petOwners: result,
    });
  });
});

app.get("/pet/length", (req, res) => {
  const sqlQuery = "SELECT * FROM pets WHERE isArchived = 0";
  db.query(sqlQuery, (err, result) => {
    if (result.length > 0) {
      res.send({
        pet: result.length,
      });
    } else {
      res.send({
        pets: 0,
      });
    }
  });
});

//for pet vaccination record #new
app.get("/petowner/vaccination/:pet_id", (req, res) => {
  const pet_id = req.params.pet_id;
  const sqlQuery =
    "SELECT * FROM vet_doctors JOIN vet_clinic ON vet_doctors.vetid = vet_clinic.vetid JOIN appointment ON appointment.vetid = vet_clinic.vetid JOIN immunization_history ON immunization_history.appointment_id = appointment.appointment_id JOIN pets ON pets.pet_id = immunization_history.pet_id WHERE pets.pet_id = ?";
  db.query(sqlQuery, pet_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//for pet consultation record
app.get("/petowner/consultation/:pet_id", (req, res) => {
  const pet_id = req.params.pet_id;
    console.log("pet id"+pet_id);
  const sqlQuery =
    "SELECT * FROM vet_clinic JOIN consultation ON vet_clinic.vetid = consultation.vetid JOIN pets ON pets.pet_id = consultation.pet_id JOIN pet_owners ON pet_owners.pet_owner_id = pets.pet_owner_id WHERE pets.pet_id =?";
  db.query(sqlQuery, pet_id, (err, result) => {
    console.log(result);
    res.send(result);
  });
});

//for pet appointment record
app.get("/petowner/apppointment/:pet_id", (req, res) => {
  const pet_id = req.params.pet_id;
  const sqlQuery =
    "SELECT * FROM vet_clinic JOIN vet_doctors ON vet_clinic.vetid = vet_doctors.vetid JOIN consultation ON consultation.vetid = vet_clinic.vetid JOIN pets ON pets.pet_id = consultation.pet_id JOIN pet_owners ON pet_owners.pet_owner_id = pets.pet_owner_id WHERE pets.pet_id =?";
  db.query(sqlQuery, pet_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});
app.get("/vetclinic/length", (req, res) => {
  const sqlQuery =
    "SELECT * FROM vet_clinic WHERE vet_status = 'Verified' AND isArchived = 0";
  db.query(sqlQuery, (err, result) => {
    // console.log(result.length);
    res.send({
      vetclinic: result.length,
    });
  });
});

app.get("/pending/vetclinic/length", (req, res) => {
  const sqlQuery = "SELECT * FROM vet_clinic WHERE vet_status = 'Pending'";
  db.query(sqlQuery, (err, result) => {
    // console.log(result.length);
    res.send({
      pending: result.length,
    });
  });
});

app.get("/pets/dogs/admin", (req, res) => {
  const sqlQuery = "SELECT * FROM pets WHERE type_of_pet = 'Dog'";
  db.query(sqlQuery, (err, result) => {
    // console.log(result.length);
    res.send({
      dog: result.length,
    });
  });
});

app.get("/pets/cat/admin", (req, res) => {
  const sqlQuery = "SELECT * FROM pets WHERE type_of_pet = 'Cat'";
  db.query(sqlQuery, (err, result) => {
    // console.log(result.length);
    res.send({
      cat: result.length,
    });
  });
});

app.get("/pets/fish", (req, res) => {
  const sqlQuery = "SELECT * FROM pets WHERE type_of_pet = 'Fish'";
  db.query(sqlQuery, (err, result) => {
    // console.log(result.length);
    res.send({
      fish: result.length,
    });
  });
});

app.get("/pets/bird", (req, res) => {
  const sqlQuery = "SELECT * FROM pets WHERE type_of_pet = 'Bird'";
  db.query(sqlQuery, (err, result) => {
    // console.log(result.length);
    res.send({
      bird: result.length,
    });
  });
});

app.get("/pets/turtle", (req, res) => {
  const sqlQuery = "SELECT * FROM pets WHERE type_of_pet = 'Turtle'";
  db.query(sqlQuery, (err, result) => {
    // console.log(result.length);
    res.send({
      turtle: result.length,
    });
  });
});

app.get("/pets/hamster", (req, res) => {
  const sqlQuery = "SELECT * FROM pets WHERE type_of_pet = 'Hamster'";
  db.query(sqlQuery, (err, result) => {
    // console.log(result.length);
    res.send({
      hamster: result.length,
    });
  });
});

app.get("/pets/gender/male", (req, res) => {
  const sqlQuery =
    "SELECT * FROM pets WHERE gender = 'Male' AND isArchived = 'False'";
  db.query(sqlQuery, (err, result) => {
    // console.log(result.length);
    res.send({
      male: result.length,
    });
  });
});

app.get("/pets/gender/female", (req, res) => {
  const sqlQuery =
    "SELECT * FROM pets WHERE gender = 'Female' AND isArchived = 'False'";
  db.query(sqlQuery, (err, result) => {
    // console.log(result.length);
    res.send({
      female: result.length,
    });
  });
});

//------------------------------- ------------dashboard get data vet clinic admin-------------------------------------------//
//this api is for dashboard of vet admin

app.get("/pets/:id", (req, res) => {
  const vetAdminId = req.params.id.substring(1);
  // console.log(vetAdminId);
  const sqlQuery =
    "SELECT medical_history.medical_history_id, pets.pet_name,pets.type_of_pet,pets.breed_of_pet,pets.gender FROM pets INNER JOIN medical_history ON pets.pet_id=medical_history.pet_id WHERE vet_admin_id = ?;";
  db.query(sqlQuery, vetAdminId, (err, result) => {
    // console.log(err);
    res.send(result);
    // console.log(result)
  });
});

app.get("/vetRatings/admin", (req, res) => {
  // console.log(vetAdminId);
  const sqlQuery =
    "SELECT appointment.vetid,vet_clinic.vet_name, AVG(rate_feedback.ratings) AS averageRatings FROM rate_feedback JOIN appointment ON rate_feedback.appointment_id = appointment.appointment_id JOIN vet_clinic USING (vetid) GROUP BY vetid ORDER BY vetid";

  db.query(sqlQuery, (err, result) => {
    // console.log(err);
    res.send(result);
    // console.log(result)
  });
});

//Get total number of dog
app.get("/vetclinic/dog/length/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(vetid);
  const sqlQuery =
    "SELECT DISTINCT pets.pet_id FROM pets JOIN appointment ON pets.pet_id = appointment.pet_id JOIN vet_clinic ON vet_clinic.vetid = appointment.vetid WHERE vet_clinic.vetid = ? AND appointment.appointment_status = 'Done' AND pets.type_of_pet= 'Dog'";

  db.query(sqlQuery, vetid, (err, result) => {
    console.log(result.length);
    res.send({
      dog: result.length,
    });
    // console.log(result)
  });
});

//Get total number of cat
app.get("/vetclinic/cat/length/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(vetAdminId);
  const sqlQuery =
    "SELECT DISTINCT pets.pet_id FROM pets JOIN appointment ON pets.pet_id = appointment.pet_id JOIN vet_clinic ON vet_clinic.vetid = appointment.vetid WHERE vet_clinic.vetid = ? AND appointment.appointment_status = 'Done' AND pets.type_of_pet= 'Cat'";

  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result.length);
    res.send({
      cat: result.length,
    });
  });
});

//--------------------------------------------------------Appointment Get, Add, Delete, Update---------------------------------------------//
//Appointments API
app.post("/appointment/set", (req, res) => {
  const vet_admin_id = req.body.vet_admin_id;
  const pet_owner_id = req.body.pet_owner_id;
  // const pet_owner_name = req.body.pet_owner_name;
  // const vet_clinic_name = req.body.vet_clinic_name;
  // const service_name = req.body.service_name;
  const pet_id = req.body.pet_id;
  const dateSet = req.body.dateSet;
  const timeSet = req.body.timeSet;
  const service_id = req.body.service_id;
  // console.log(vet_admin_id);
  // var logsDescrip = {
  //   pet_owner_id: pet_owner_id,
  //   pet_owner_name: pet_owner_name,
  //   vet_admin_id: vet_admin_id,
  //   vet_clinic_name: vet_clinic_name,
  //   appoinment_type: "Pending",
  //   service_name: service_name,
  // };
  const sqlQuery =
    "INSERT INTO appointment (vetid,pet_owner_id,pet_id,time_scheduled,date_scheduled,service_id,appointment_status) VALUES (?,?,?,?,?,?,?)";
  db.query(
    sqlQuery,
    [
      vet_admin_id,
      pet_owner_id,
      pet_id,
      timeSet,
      dateSet,
      service_id,
      "Pending",
    ],
    (err, result) => {
      console.log(result);
      console.log(err);
      if (err === null) {
        res.send({
          message: "Success",
        });
        // const sqlQueryLogs =
        //   "INSERT INTO system_logs (logs_description,logs_type) VALUES (?,?)";
        // db.query(sqlQueryLogs, [logsDescrip, 1], (err, result) => {
        //   if (err === null) {
        //     res.send({
        //       message: "Inserted to system logs",
        //     });
        //   }
        // });
      }
    }
  );
});

// Get appointment for pet owner approved
app.get("/appointments/:pet_owner_id", (req, res) => {
  const pet_owner_id = req.params.pet_owner_id;
  // console.log(pet_owner_id)
  const sqlQuery = `SELECT * FROM appointment INNER JOIN services ON  appointment.service_id = services.service_id INNER JOIN vet_clinic ON vet_clinic.vetid = appointment.vetid WHERE pet_owner_id = ? AND appointment.appointment_status = 'Approved'`;

  db.query(sqlQuery, pet_owner_id.substring(1), (err, result) => {
    // console.log(err);
    if (err === null) {
      res.send(result);
      // console.log(result);
    } else {
      console.log(err);
    }
  });
});

// Get appointment for pet owner done
app.get("/appointments/histories/:pet_owner_id", (req, res) => {
  const pet_owner_id = req.params.pet_owner_id;
  // console.log(pet_owner_id)
  const sqlQuery =
    "SELECT * FROM appointment INNER JOIN services ON  appointment.service_id = services.service_id INNER JOIN vet_clinic ON vet_clinic.vetid = appointment.vetid WHERE pet_owner_id = ? AND appointment.appointment_status = 'Done' ORDER BY appointment.logs DESC";

  db.query(sqlQuery, pet_owner_id.substring(1), (err, result) => {
    // console.log(err);
    if (err === null) {
      res.send(result);
      // console.log(result);
    } else {
      console.log(err);
    }
  });
});

// Get appointment for pet owner approved
app.get("/appointments/pending/:pet_owner_id", (req, res) => {
  const pet_owner_id = req.params.pet_owner_id;
  // console.log(pet_owner_id)
  const sqlQuery = `SELECT * FROM appointment INNER JOIN services ON  appointment.service_id = services.service_id INNER JOIN vet_clinic ON vet_clinic.vetid = appointment.vetid WHERE pet_owner_id = ? AND appointment.appointment_status = 'Pending' ORDER BY appointment.appointment_id DESC`;

  db.query(sqlQuery, pet_owner_id.substring(1), (err, result) => {
    // console.log(err);
    if (err === null) {
      res.send(result);
      // console.log(result);
    } else {
      console.log(err);
    }
  });
});

// Get History appointment for pet owner
app.get("/appointments/history/record/:pet_owner_id", (req, res) => {
  const pet_owner_id = req.params.pet_owner_id;
  // console.log(pet_owner_id);
  const sqlQuery = `SELECT * FROM appointment INNER JOIN services ON  appointment.service_id = services.service_id INNER JOIN vet_clinic ON vet_clinic.vetid = appointment.vetid WHERE pet_owner_id = ? AND (appointment.appointment_status = 'Done' OR appointment.appointment_status = 'Decline')`;

  db.query(sqlQuery, pet_owner_id.substring(1), (err, result) => {
    // console.log(err);
    if (err === null) {
      res.send(result);
      // console.log(result);
    } else {
      console.log(err);
    }
  });
});

//API for Pending Appointments
app.get("/pending/appointment/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(vetid)
  const sqlQuery =
    "SELECT * FROM pet_owners JOIN appointment ON pet_owners.pet_owner_id=appointment.pet_owner_id JOIN services ON services.service_id=appointment.service_id WHERE appointment.vetid = ? AND appointment.appointment_status='Pending' ORDER BY appointment.appointment_id DESC";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//API for General Appointments
app.get("/general/appointment/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(vetid)
  const sqlQuery =
    "SELECT * FROM pet_owners JOIN pets ON pet_owners.pet_owner_id = pets.pet_owner_id JOIN appointment ON appointment.pet_id = pets.pet_id JOIN services ON services.service_id=appointment.service_id WHERE appointment.vetid = ? AND appointment.appointment_status='Approved' ORDER BY appointment.appointment_id DESC";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//API for Appointment history
app.get("/history/appointment/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(vetid)
  const sqlQuery =
    "SELECT * FROM pet_owners JOIN pets ON pet_owners.pet_owner_id = pets.pet_owner_id JOIN appointment ON appointment.pet_id = pets.pet_id JOIN services ON services.service_id=appointment.service_id WHERE appointment.vetid = ? AND appointment.appointment_status IN ('Done', 'Decline') ORDER BY appointment.logs DESC";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//API for View details Appointments
app.get("/pending/appointment/viewdetails/:appointment_id", (req, res) => {
  const appointment_id = req.params.appointment_id;
  // console.log(appointment_id)
  const sqlQuery =
    "SELECT * FROM pet_owners JOIN pets ON pet_owners.pet_owner_id = pets.pet_owner_id JOIN appointment ON appointment.pet_id = pets.pet_id JOIN services ON services.service_id=appointment.service_id WHERE appointment.appointment_id = ? AND appointment.appointment_status='Pending'";
  db.query(sqlQuery, appointment_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//API for View details Appointments history
app.get("/appointment/viewdetails/:appointment_id", (req, res) => {
  const appointment_id = req.params.appointment_id;
  // console.log(appointment_id)
  const sqlQuery =
    "SELECT * FROM pet_owners JOIN appointment ON pet_owners.pet_owner_id=appointment.pet_owner_id JOIN services ON services.service_id=appointment.service_id WHERE appointment.appointment_id = ? AND appointment.appointment_status='Done' OR appointment.appointment_status='Decline'";
  db.query(sqlQuery, appointment_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//API for View details confirm Appointments
app.get("/confirm/appointment/viewdetails/:appointment_id", (req, res) => {
  const appointment_id = req.params.appointment_id;
  // console.log(appointment_id)
  const sqlQuery =
    "SELECT * FROM pets JOIN pet_owners ON pets.pet_owner_id = pet_owners.pet_owner_id JOIN appointment ON pet_owners.pet_owner_id=appointment.pet_owner_id JOIN services ON services.service_id=appointment.service_id WHERE appointment.appointment_id = ? AND appointment.appointment_status='Approved'";
  db.query(sqlQuery, appointment_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

app.get("/vetclinic/services/:service_id", (req, res) => {
  const service_id = req.params.service_id;
  // console.log(service_id)
  const sqlQuery = "SELECT * FROM services WHERE service_id = ? ";
  db.query(sqlQuery, service_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

// API for accepting appointment
app.put("/vetclinic/appointment/accept/:appointment_id", (req, res) => {
  const appointment_id = req.params.appointment_id;
  // console.log(appointment_id);

  var date = new Date();
  date.setHours(date.getHours() + 8);
  var isoDate = date.toISOString();

  const sqlQuery =
    "UPDATE appointment SET appointment_status = 'Approved', date_accomplished = ? WHERE appointment_id = ? ";
  db.query(sqlQuery, [isoDate, appointment_id], (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

// API for declining appointment
//app.put("/vetclinic/appointment/decline/", (req, res) => {
app.put("/vetclinic/appointment/decline/:appointment_id", (req, res) => {
  const appointment_id = req.params.appointment_id;
  // console.log(appointment_id);
  var date = new Date();
  date.setHours(date.getHours() + 8);
  var isoDate = date.toISOString();

  const sqlQuery =
    "UPDATE appointment SET appointment_status = 'Decline', date_accomplished = ? WHERE appointment_id = ? ";
  db.query(sqlQuery, [isoDate, appointment_id], (err, result) => {
    // console.log(result);

    res.send(result);
  });
});

// API for finishing appointment
app.put("/vetclinic/appointment/done/:appointment_id", (req, res) => {
  const appointment_id = req.params.appointment_id;
  // console.log(appointment_id);
  var date = new Date();
  date.setHours(date.getHours() + 8);
  var isoDate = date.toISOString();

  const sqlQuery =
    "UPDATE appointment SET appointment_status = 'Done', date_accomplished = ? WHERE appointment_id = ? ";
  db.query(sqlQuery, [isoDate, appointment_id], (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//----------------------------------------------------Talk to Vet---------------------------------------//
// Talk to vet

//add thread
app.post("/talktovet/thread/creating", (req, res) => {
  const pet_owner_id = req.body.pet_owner_id;
  const vetid = req.body.vetid;
  console.log(vetid);
  const sqlQuery = "INSERT INTO thread (pet_owner_id,vetid) VALUES (?,?) ";
  db.query(sqlQuery, [pet_owner_id, vetid], (err, result) => {
    console.log(result);
    res.send(result);
  });
});

// Get Thread Vet Clinic
app.get("/talktovet/vetclinic/thread/:vetid", (req, res) => {
  const vetid = req.params.vetid;

  // console.log(vetid);
  const sqlQuery = `SELECT * FROM pet_owners JOIN thread ON pet_owners.pet_owner_id = thread.pet_owner_id JOIN vet_clinic ON vet_clinic.vetid = thread.vetid WHERE vet_clinic.vetid = ? ORDER BY thread.thread_id ASC`;
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

// Get Thread for refresh message Vet Clinic
app.post("/talktovet/vetclinic/thread/refresh", (req, res) => {
  const vetid = req.body.vetid;

  // console.log(vetid);
  const sqlQuery = `SELECT thread.thread_id FROM pet_owners JOIN thread ON pet_owners.pet_owner_id = thread.pet_owner_id JOIN vet_clinic ON vet_clinic.vetid = thread.vetid WHERE vet_clinic.vetid = ? ORDER BY thread.thread_id ASC`;
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

// Get Thread Pet Owner
app.get("/talktovet/petOwner/thread/:petOwnerId/:vetid", (req, res) => {
  const petOwnerId = req.params.petOwnerId;
  const vetid = req.params.vetid;

  const sqlQuery = `SELECT * FROM pet_owners JOIN thread ON pet_owners.pet_owner_id = thread.pet_owner_id JOIN vet_clinic ON vet_clinic.vetid = thread.vetid WHERE thread.pet_owner_id = ? AND thread.vetid = ? ORDER BY thread.thread_id ASC`;
  db.query(sqlQuery, [petOwnerId, vetid], (err, result) => {
    // console.log(result);
    res.send(result);
  });
});


///check if vet_id existing
app.get("/talktovet/petOwner/vetclinic/:vetid/:pet_owner_id", (req, res) => {
  const petOwnerId = req.params.pet_owner_id;
  const vetid = req.params.vetid;
  console.log(petOwnerId);
  const sqlQuery = `SELECT * FROM thread WHERE vetid = ? AND pet_owner_id = ?`;
  db.query(sqlQuery, [vetid, petOwnerId], (err, result) => {

    if (err == null && result.length != 0) {
      res.send({ message: 'Exist' })
    } else if (err == null && result.length == 0) {
      res.send({ message: 'not Exist' })
    } else {
      console.log(err);
    }
  });
});

// Get Thread Pet Owner Mobile
app.post("/mobile/talktovet/petOwner/thread", (req, res) => {
  const petOwnerId = req.body.petOwnerId;

  const sqlQuery = `SELECT messages.message_content, thread.thread_id, vet_clinic.vet_picture, vet_clinic.vet_name, vet_clinic.vetid, messages.created_time_date FROM pet_owners JOIN messages ON pet_owners.pet_owner_id = messages.pet_owner_id JOIN thread ON thread.thread_id = messages.thread_id JOIN vet_clinic ON vet_clinic.vetid = thread.vetid WHERE pet_owners.pet_owner_id = ? && messages.message_id in (SELECT MAX(messages.message_id) FROM messages GROUP BY thread_id )`;
  db.query(sqlQuery, petOwnerId, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

// Get Thread for refresh message Pet Owner
app.post("/talktovet/petOwner/thread/refresh", (req, res) => {
  const petOwnerId = req.body.petOwnerId;

  const sqlQuery = `SELECT thread.thread_id FROM pet_owners JOIN thread ON pet_owners.pet_owner_id = thread.pet_owner_id JOIN vet_clinic ON vet_clinic.vetid = thread.vetid WHERE pet_owners.pet_owner_id = ? ORDER BY thread.thread_id ASC`;
  db.query(sqlQuery, petOwnerId, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

// Get Thread and message for Vet Clinic
app.get("/talktovet/vetclinic/messages/:thread_id", (req, res) => {
  const thread_id = req.params.thread_id;

  // console.log(thread_id);
  const sqlQuery = `SELECT thread.thread_id, vet_clinic.vet_name,vet_clinic.vet_picture,pet_owners.name,pet_owners.profilePicture,messages.user_message,messages.message_content,messages.created_time_date FROM pet_owners JOIN messages ON pet_owners.pet_owner_id = messages.pet_owner_id JOIN thread ON thread.thread_id = messages.thread_id JOIN vet_clinic ON vet_clinic.vetid = thread.vetid WHERE thread.thread_id= ? ORDER BY messages.created_time_date ASC`;
  db.query(sqlQuery, thread_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

// Send message for Vet Clinic
app.post("/talktovet/vetclinic/messages/sent", (req, res) => {
  const thread_id = req.body.thread_id;
  const pet_owner_id = req.body.pet_owner_id;
  const vetid = req.body.vetid;
  const user = req.body.user;
  const message = req.body.message;

  const sqlQuery = `INSERT INTO messages (thread_id,pet_owner_id,vetid,user_message,message_content) VALUES (?,?,?,?,?)`;
  db.query(
    sqlQuery,
    [thread_id, pet_owner_id, vetid, user, message],
    (err, result) => {
      // console.log(err);
      if (err == null) {
        res.send({ result: "Success" });
      } else {
        console.log(err);
      }
    }
  );
});

// Talk to vet check thread exist
app.post("/talktovet/thread/exist", (req, res) => {
  const pet_owner_id = req.body.pet_owner_id;
  const vetid = req.body.vetid;
  console.log(pet_owner_id);
  console.log(vetid);
  db.query(
    "SELECT * FROM thread WHERE pet_owner_id = ? AND vetid = ?",
    [pet_owner_id, vetid],
    (err, result) => {
      console.log(result);
      if (result.length <= 0) {
        res.send({ exist: false });
      } else {
        res.send({ exist: true });
      }
    }
  );
});

//-----------------------------------------------Authenticate Token-----------------------------------------//

function authenticateToken(req, res, next) {
  const authHeader = req.headers["authorization"];
  const token = authHeader && authHeader.split(" ")[1];
  if (token == null) return res.sendStatus(401);

  jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, user) => {
    // console.log(err);
    if (err) return res.sendStatus(403);
    req.user = user;
    next();
  });
}

// --------------------------------------------------GenerateAccessToken ------------------------------//
function generateAccessToken(user) {
  return jwt.sign(user, process.env.ACCESS_TOKEN_SECRET, { expiresIn: "1d" });
}

//--------------------------------------------------------------------------//

//API for dashboard in vet clinic
app.get("/pets/vetclinic/length/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  console.log(vetid);
  const sqlQuery =
    "SELECT DISTINCT pet_id FROM appointment where vetid=? && appointment.appointment_status = 'Done'";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result.length);
    res.send({
      pets: result.length,
      // pets: 4,
    });
  });
});

// app.get("/petowner/vetclinic/length/:vetid", (req, res) => {
//   const vetid = req.params.vetid;
//   //console.log(vet_admin_id)
//   const sqlQuery =
//     "SELECT DISTINCT pet_owner_id FROM appointment where vet_admin_id=?";
//   db.query(sqlQuery, vet_admin_id.substring(1), (err, result) => {
//     res.send({
//       petOwners: 4,
//     });
//   });
// });

app.get("/reserved/vetclinic/length/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  //console.log(vet_admin_id)
  const sqlQuery =
    "SELECT * FROM reservation where vetid=? && reservation_status= 'Pending'";
  db.query(sqlQuery, vetid, (err, result) => {
    res.send({
      reserved: result.length,
    });
  });
});

app.get("/pending/vetclinic/length/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  //console.log(vet_admin_id)
  const sqlQuery =
    "SELECT * FROM appointment WHERE vetid=? && appointment_status='Pending'";
  db.query(sqlQuery, vetid, (err, result) => {
    res.send({
      pending: result.length,
    });
  });
});

//Specific vet clinic overall rating
app.get("/vetRatings/vetclinic/length/:vetid", (req, res) => {
  // console.log(vetAdminId);
  const vetid = req.params.vetid;
  if (vetid != undefined) {
    const sqlQuery =
      "SELECT AVG(rate_feedback.ratings) AS averageRatings FROM rate_feedback JOIN appointment ON rate_feedback.appointment_id = appointment.appointment_id JOIN vet_clinic USING (vetid) WHERE vet_clinic.vetid =? GROUP BY vetid ORDER BY vetid";

    db.query(sqlQuery, vetid.substring(1), (err, result) => {
      var resultData = JSON.parse(JSON.stringify(result));
      // console.log(resultData[0]);
      res.send(resultData[0]);
      // console.log(result)
    });
  }
});

//Animal population Graph
//Dog (Specific individual pets query)
app.get("/dog/total/:vet_admin_id", (req, res) => {
  const vet_admin_id = req.params.vet_admin_id;

  const sqlQuery =
    "SELECT DISTINCT appointment.pet_id, pets.type_of_pet FROM pets JOIN appointment ON pets.pet_id=appointment.pet_id WHERE appointment.vet_admin_id=? && pets.type_of_pet='Dog'";
  db.query(sqlQuery, vet_admin_id.substring(1), (err, result) => {
    res.send({
      dog: result.length,
    });
  });
});

//Dynamic type of pets and its value
app.get("/total/animal/population/:vet_admin_id", (req, res) => {
  const vet_admin_id = req.params.vet_admin_id;

  const sqlQuery =
    "SELECT type_of_pet,  COUNT( DISTINCT appointment.pet_id) AS 'TOTAL' FROM pets JOIN appointment ON pets.pet_id=appointment.pet_id WHERE appointment.vet_admin_id=? GROUP BY type_of_pet";
  db.query(sqlQuery, vet_admin_id.substring(1), (err, result) => {
    res.send(result);
  });
});

//System Admin

//authenticate system admin upon uploading updatimg credentials
app.get("/admin/update/credentials", (req, res) => {
  //Authenticate
  // console.log("here");
  const email = req.query.email;

  db.query("SELECT * FROM user_role WHERE email = ?", email, (err, result) => {
    if (err) {
      res.send({ err: err });
    }

    if (result[0].userrole == 3) {
      db.query(
        "SELECT * FROM system_administrator WHERE email = ?",
        email,
        (err, result) => {
          if (err) {
            res.send({ err: err });
          }
          const user = { result };
          // console.log(user);
          const accessToken = generateAccessToken(user);
          const refreshToken = jwt.sign(user, process.env.REFRESH_TOKEN_SECRET);
          refreshTokens.push(refreshToken);
          // let u = JSON.parse(JSON.stringify(user));
          // console.log(u.result[0].name)
          res.send({
            accessToken: accessToken,
            refreshToken: refreshToken,
            message: "Correct",
            role: 3,
            id: result[0].admin_id,
          });
        }
      );
    }
  });
});

//Update System Admin Information
app.put("/admin/update/:admin_id", (req, res) => {
  const admin_id = req.params.admin_id;
  const updateAdminName = req.body.updateAdminName;
  const updateAdminEmail = req.body.updateAdminEmail;

  const sqlQuery =
    "UPDATE system_administrator SET email = ?,name = ? WHERE admin_id = ?";
  db.query(
    sqlQuery,
    [updateAdminEmail, updateAdminName, admin_id],
    (err, result) => {
      if (err === null) {
        res.send({ message: "Correct" });
      } else {
        console.log(err);
      }
    }
  );
});

//Change Password System Admin
app.put("/admin/update/password/:admin_id", (req, res) => {
  const admin_id = req.params.admin_id;
  const updateAdminPassword = req.body.updateAdminPassword;

  bcrypt.hash(updateAdminPassword, saltRounds, (err, hash) => {
    const sqlQuery =
      "UPDATE system_administrator SET password = ?  WHERE admin_id = ?";
    db.query(sqlQuery, [hash, petowner_id], (err, result) => {
      if (err === null) {
        res.send({ message: "Correct" });
      } else {
        console.log(err);
      }
    });
  });
});

//Visitor monitoring for vet_clinic
app.get("/vetclinic/visitor/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(vetid);
  const sqlQuery =
    "SELECT * FROM pet_owners JOIN visitor_monitoring ON pet_owners.pet_owner_id = visitor_monitoring.pet_owner_id JOIN vet_clinic ON vet_clinic.vetid = visitor_monitoring.vetid WHERE vet_clinic.vetid = ? ";
  db.query(sqlQuery, vetid, (err, result) => {
    console.log(result);
    res.send(result);
  });
});

//Visitor monitoring for pet_owner
app.get("/petOwner/visitor/:pet_owner_id", (req, res) => {
  const pet_owner_id = req.params.pet_owner_id;
  // console.log(pet_owner_id);
  const sqlQuery =
    "SELECT * FROM pet_owners JOIN visitor_monitoring ON pet_owners.pet_owner_id = visitor_monitoring.pet_owner_id JOIN vet_clinic ON vet_clinic.vetid = visitor_monitoring.vetid WHERE pet_owners.pet_owner_id = ? ";
  db.query(sqlQuery, pet_owner_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//Inserting Notification
app.post("/notification/appointment", (req, res) => {
  const appointment_id = req.body.appointment_id;
  const service_id = req.body.service_id;
  const status = req.body.status;
  // const date_time_created = req.body.date_time_created;
  console.log("Inserted in notif");
  const sqlQuery = `INSERT  INTO notifications (appointment_id,service_id,status) VALUES (?,?,?)`;
  db.query(sqlQuery, [appointment_id, service_id, status], (err, result) => {
    console.log(result);
    res.send(result);
  });
});

//Notification for pet owner Appointment
app.get("/petOwner/notification/:pet_owner_id", (req, res) => {
  const pet_owner_id = req.params.pet_owner_id;
  // console.log(pet_owner_id);
  const sqlQuery =
    "SELECT pet_owners.pet_owner_id ,vet_clinic.vet_picture, vet_clinic.vet_name, services.service_name, notifications.status, notifications.date_time_created FROM pet_owners JOIN appointment ON pet_owners.pet_owner_id = appointment.pet_owner_id JOIN notifications ON notifications.appointment_id = appointment.appointment_id JOIN services  ON services.service_id = notifications.service_id JOIN vet_clinic ON vet_clinic.vetid = services.vetid WHERE pet_owners.pet_owner_id = ? AND NOT notifications.status = 'Pending' ORDER BY notifications.date_time_created DESC";
  db.query(sqlQuery, pet_owner_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//Notification for vet clinic
app.get("/vetclinic/notification/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(pet_owner_id);
  const sqlQuery =
    "SELECT pet_owners.profilePicture, pet_owners.name, services.service_name, notifications.status, notifications.date_time_created FROM pet_owners JOIN appointment ON pet_owners.pet_owner_id = appointment.pet_owner_id JOIN notifications ON notifications.appointment_id = appointment.appointment_id JOIN services  ON services.service_id = notifications.service_id JOIN vet_clinic ON vet_clinic.vetid = services.vetid WHERE vet_clinic.vetid = ? && notifications.status IN ('Done', 'Cancelled')  ORDER BY notifications.date_time_created DESC ";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//Change Password Web

//Get password of the Pet Owner
// app.get("/web/petowner/password/:pet_owner_id", (req,res) =>{
//   const pet_owner_id = req.params.pet_owner_id;
//   // const currentPassword = req.body.currentPassword;

//   const sqlQuery = "SELECT pet_owners.password FROM pet_owners WHERE pet_owners.pet_owner_id = ? "
//   db.query(sqlQuery, pet_owner_id, (err, result) => {
//     res.send(result);
//   });
// });

//Compare user input and db password
app.post("/web/user/compare", (req, res) => {
  const currentHashPassword = req.body.currentHashPassword;
  const currentPassword = req.body.currentPassword;

  console.log(currentPassword);
  // console.log(currentHashPassword);

  bcrypt.compare(currentPassword, currentHashPassword, function (err, result) {
    console.log(result);
    if (result) {
      res.send(true);
    } else {
      res.send(false);
    }
  });
});

//Changing Password for Pet Owner
app.put("/web/petowner/password/:pet_owner_id", (req, res) => {
  const pet_owner_id = req.params.pet_owner_id;
  const newPassword = req.body.newPassword;

  bcrypt.hash(newPassword, saltRounds, (err, hash) => {
    if (err) {
      console.log(err);
    }
    const sqlQuery =
      "UPDATE pet_owners SET password = ?  WHERE pet_owner_id = ?";
    db.query(sqlQuery, [hash, pet_owner_id], (err, result) => {
      if (err === null) {
        res.send({ message: "Successfully" });
      } else {
        console.log(err);
      }
    });
  });
});

//Changing Password for Vet Clinic
app.put("/web/vetclinic/password/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  const newPassword = req.body.newPassword;

  bcrypt.hash(newPassword, saltRounds, (err, hash) => {
    if (err) {
      console.log(err);
    }
    const sqlQuery = "UPDATE vet_clinic SET password = ?  WHERE vetid = ?";
    db.query(sqlQuery, [hash, vetid], (err, result) => {
      if (err === null) {
        res.send({ message: "Successfully" });
      } else {
        console.log(err);
      }
    });
  });
});

//staff change password
app.put("/web/vetstaff/password/:staffId", (req, res) => {
  const staff_id = req.params.staffId;
  const newPassword = req.body.newPassword;

  bcrypt.hash(newPassword, saltRounds, (err, hash) => {
    if (err) {
      console.log(err);
    }
    const sqlQuery =
      "UPDATE vet_staff SET vet_staff_password = ?  WHERE vet_staff_id = ?";
    db.query(sqlQuery, [hash, staff_id], (err, result) => {
      if (err === null) {
        res.send({ message: "Successfully" });
      } else {
        console.log(err);
      }
    });
  });
});

//doc change password
app.put("/web/doc/password/:docId", (req, res) => {
  const doc_id = req.params.docId;
  const newPassword = req.body.newPassword;

  bcrypt.hash(newPassword, saltRounds, (err, hash) => {
    if (err) {
      console.log(err);
    }
    const sqlQuery =
      "UPDATE vet_doctors SET vet_doc_password = ?  WHERE vet_doc_id = ?";
    db.query(sqlQuery, [hash, doc_id], (err, result) => {
      if (err === null) {
        res.send({ message: "Successfully" });
      } else {
        console.log(err);
      }
    });
  });
});

//Changing Password for System Admin
app.put("/web/admin/password/:admin_id", (req, res) => {
  const admin_id = req.params.admin_id;
  const newPassword = req.body.newPassword;

  bcrypt.hash(newPassword, saltRounds, (err, hash) => {
    if (err) {
      console.log(err);
    }
    const sqlQuery =
      "UPDATE system_administrator SET password = ?  WHERE admin_id = ?";
    db.query(sqlQuery, [hash, admin_id], (err, result) => {
      if (err === null) {
        res.send({ message: "Successfully" });
      } else {
        console.log(err);
      }
    });
  });
});

//Send sms code
app.post("/sendSMS/:phoneNumber", (req, res) => {
  const phoneNumber = req.params.phoneNumber;

  const verificationCode = Math.floor(Math.random() * (9999 - 1000 + 1) + 1000);
  const sqlQuery = "SELECT userrole FROM user_role WHERE phone_number = ?";
  db.query(sqlQuery, phoneNumber, (err, result) => {
    if (result !== undefined) {
      if (result.length > 0) {
        console.log(JSON.stringify(result[0]["userrole"]));
        // console.log(err);
        res.send({ message: "valid number" });
        const accountSid = "AC1d13c48bd74f0c915a132a46f15305d1";
        const authToken = "bc12c3de798e634ce4d7a8f8ff59dff0";
        const client = require("twilio")(accountSid, authToken);

        client.messages
          .create({
            body: `Your Verification code ${verificationCode}`,
            messagingServiceSid: "MG5cba79bc34b8ff14404ea5dd2a240a8f",
            to: `+63${phoneNumber.substring(1)}`,
          })
          .then((message) => {
            console.log(message);
            res.send(message);
          })
          .catch((err) => {
            console.log("Error");
          })
          .done();
        const sqlQueryInsert =
          "INSERT INTO forget_password (phone_number,verification_code) VALUES (?,?)";
        db.query(
          sqlQueryInsert,
          [phoneNumber, verificationCode],
          (err, result) => { }
        );
      } else {
        console.log("invalid number");
        res.send({ message: "invalid number" });
      }
    } else {
      console.log("Network Error");
    }
  });
});

app.post("/sendSMS/verify/:phoneNumber", (req, res) => {
  const phoneNumber = req.params.phoneNumber;
  const verificationCode = req.body.verificationCode;

  const query =
    "SELECT * FROM forget_password INNER JOIN user_role ON forget_password.phone_number = user_role.phone_number WHERE forget_password.phone_number = ? AND forget_password.verification_code = ?";
  db.query(query, [phoneNumber, verificationCode], (err, result) => {
    if (err !== null) {
      console.log(err);
    }
    if (result.length > 0) {
      console.log(result);
      res.send({ message: "success", datas: result });
    } else {
      res.send({ message: "failed" });
    }
  });
});

app.put("/petowner/change/:petowner_id", (req, res) => {
  const petowner_id = req.params.petowner_id;
  const profilePicture = req.body.profilePicture;

  const sqlQuery =
    "UPDATE pet_owners SET profilePicture = ? WHERE pet_owner_id = ? ";
  db.query(sqlQuery, [profilePicture, petowner_id], (err, result) => {
    if (err === null) {
      res.send({ message: "Correct" });
    } else {
      console.log(err);
    }
  });
});

///change Profile pic
app.put("/petowner/change/profile/:petowner_id", (req, res) => {
  const petowner_id = req.params.petowner_id;
  const profilePicture = req.body.profilePicture;
  console.log(profilePicture);
  const sqlQuery =
    "UPDATE pet_owners SET profilePicture = ? WHERE pet_owner_id = ? ";
  db.query(sqlQuery, [profilePicture, petowner_id], (err, result) => {
    if (err == null) {
      res.send({ message: "Correct" });
    } else {
      res.send({ message: "error" });
    }
  });
});

app.put("/pet/change/profile/:pet_id", (req, res) => {
  const pet_id = req.params.pet_id;
  const pet_picture = req.body.pet_picture;
  const sqlQuery = "UPDATE pets SET pet_picture = ? WHERE pet_id = ? ";
  db.query(sqlQuery, [pet_picture, pet_id], (err, result) => {
    if (err == null) {
      res.send({ message: "Correct" });
    } else {
      res.send({ message: "error" });
    }
  });
});
//change password
app.post("/changepassword/:password", (req, res) => {
  const password = req.params.password;
  const user_role = req.body.userrole;
  const phoneNumber = req.body.phoneNumber;
  // console.log(user_role);
  bcrypt.hash(password, saltRounds, (err, hash) => {
    if (err) {
      console.log(err);
    }

    if (user_role == 1) {
      const query =
        "UPDATE pet_owners SET password = ? WHERE contact_number = ?";
      db.query(query, [hash, phoneNumber, phoneNumber], (err, result) => {
        // console.log(result);
        if (JSON.parse(JSON.stringify(result)).changedRows > 0) {
          res.sendStatus(200);
        } else {
          res.send({ message: "failed" });
        }
      });
    } else if (user_role == 2) {
      const query =
        "UPDATE vet_clinic SET password = ? WHERE vet_contact_number = ?";
      db.query(query, [hash, phoneNumber], (err, result) => {
        if (result !== null) {
          res.sendStatus(200);
        } else {
          res.send({ message: "failed" });
        }
      });
    } else if (user_role == 3) {
      const query =
        "UPDATE system_administrator SET password = ? WHERE phone_number = ?";
      db.query(query, [hash, phoneNumber], (err, result) => {
        if (result !== null) {
          res.sendStatus(200);
        } else {
          res.send({ message: "failed" });
        }
      });
    }
  });
});

//Contact tracing Mobile

app.post("/contact/tracing/insert", (req, res) => {
  const vetid = req.body.vetid;

  const pet_owner_id = req.body.pet_owner_id;

  const temperature = req.body.temperature;

  const q1 = req.body.q1;

  const q2 = req.body.q2;

  const q3 = req.body.q3;
  console.log("Inserting visitor monitoring");
  let questionOne;
  let questionTwo;
  let questionThree;

  if (q1 == "true") {
    questionOne = true;
  } else {
    questionOne = false;
  }

  if (q2 == "true") {
    questionTwo = true;
  } else {
    questionTwo = false;
  }

  if (q3 == "true") {
    questionThree = true;
  } else {
    questionThree = false;
  }

  var today = new Date();
  var date =
    today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate();
  var time =
    today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
  var dateTime = date + " " + time;
  // console.log(q3);
  const sqlQuery =
    "INSERT INTO visitor_monitoring (pet_owner_id,vetid,temperature,date_visited,time_visited,q1,q2,q3) VALUES (?,?,?,?,?,?,?,?)";

  db.query(
    sqlQuery,

    [
      pet_owner_id,
      vetid,
      temperature,
      dateTime,
      dateTime,
      questionOne,
      questionTwo,
      questionThree,
    ],

    (err, result) => {
      console.log(err);
    }
  );
});

//get vetclinic data

app.get("/vetclinic/info/:vetid", (req, res) => {
  const vetid = req.params.vetid;

  // console.log(pet_owner_id);

  const sqlQuery = "SELECT * FROM vet_clinic WHERE vetid = ?";

  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);

    res.send(result);
  });
});

//Pet registered per vet clinic
app.get("/vetclinic/registered/pets/:vetid", (req, res) => {
  const vetid = req.params.vetid;

  // console.log(pet_owner_id);

  const sqlQuery =
    "SELECT DISTINCT pets.pet_id, pets.pet_owner_name, pets.pet_name, pets.type_of_pet, pets.breed_of_pet, pets.gender, pets.birth_day, pets.pet_picture, pets.pet_owner_name, appointment.appointment_status, vet_clinic.vet_name FROM vet_clinic JOIN appointment ON vet_clinic.vetid = appointment.vetid JOIN pets ON pets.pet_id = appointment.pet_id JOIN pet_owners ON pet_owners.pet_owner_id = pets.pet_owner_id WHERE vet_clinic.vetid = ? AND appointment.appointment_status = 'Done'";

  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);

    res.send(result);
  });
});

app.get("/products/system/admin/:email", (req, res) => {
  const email = req.params.email;

  const sqlQuery =
    "SELECT * FROM products JOIN vet_clinic ON products.vetid = vet_clinic.vetid WHERE vet_clinic.email = ?";

  db.query(sqlQuery, email, (err, result) => {
    // console.log(result);

    res.send(result);
  });
});

app.get("/pharmacy/system/admin/:email", (req, res) => {
  const email = req.params.email;

  const sqlQuery =
    "SELECT * FROM pharmacy JOIN vet_clinic ON pharmacy.vetid = vet_clinic.vetid WHERE vet_clinic.email = ?";

  db.query(sqlQuery, email, (err, result) => {
    // console.log(result);

    res.send(result);
  });
});

app.get("/services/system/admin/:email", (req, res) => {
  const email = req.params.email;

  const sqlQuery =
    "SELECT * FROM services JOIN vet_clinic ON services.vetid = vet_clinic.vetid WHERE vet_clinic.email = ?";

  db.query(sqlQuery, email, (err, result) => {
    // console.log(result);

    res.send(result);
  });
});

app.get("/appointments/system/admin/:email", (req, res) => {
  const email = req.params.email;

  const sqlQuery =
    "SELECT * FROM services JOIN vet_clinic ON services.vetid = vet_clinic.vetid JOIN appointment ON vet_clinic.vetid = appointment.vetid JOIN pet_owners ON appointment.pet_owner_id = pet_owners.pet_owner_id WHERE vet_clinic.email = ?";

  db.query(sqlQuery, email, (err, result) => {
    // console.log(result);

    res.send(result);
  });
});

app.get("/reservations/system/admin/:email", (req, res) => {
  const email = req.params.email;

  const sqlQuery =
    "SELECT * FROM  vet_clinic JOIN products ON vet_clinic.vetid = products.vetid JOIN reservation ON reservation.product_id = products.product_id JOIN pet_owners ON pet_owners.pet_owner_id = reservation.pet_owner_id WHERE vet_clinic.email = ?";

  db.query(sqlQuery, email, (err, result) => {
    // console.log(result);

    res.send(result);
  });
});

///API for checking existing feedback
app.post("/ratings&feedback/exist/rate", (req, res) => {
  const appointment_id = req.body.appointment_id;
  // const pet_owner_id = req.body.pet_owner_id;
  // console.log(appointment_id);
  const query =
    "SELECT * FROM rate_feedback WHERE rate_feedback.appointment_id = ?";
  db.query(query, appointment_id, (err, result) => {
    if (result <= 0) {
      res.send({ message: false });
    } else {
      res.send({ message: true });
    }
  });
});

//------------------------------------------------------------------------------------------------------------------
//API for ratings and feedback
app.post("/ratings&feedback/:appointment_id", (req, res) => {
  const appointment_id = req.params.appointment_id;
  const ratings = req.body.ratings;
  const comments = req.body.comments;

  // var today = new Date();
  // var date =
  //   today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate();
  // var time =
  //   today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
  // var dateTime = date + " " + time;

  const query =
    "INSERT INTO rate_feedback (appointment_id,ratings,comments) VALUES (?,?,?)";
  db.query(query, [appointment_id, ratings, comments], (err, result) => {
    if (err !== null) {
      console.log(err);
    } else {
      res.send({ message: "success" });
    }
  });
});

//LOGIN - SYSTEM LOG
//Insert pet owner log
app.post("/pet_owner/system/logs", (req, res) => {
  const name = req.body.name;
  var userLogs = name + " has been logged in as petowner";
  const query =
    "INSERT INTO system_logs (logs_description,logs_type) VALUES (?,?)";
  db.query(query, [userLogs, 1], (err, result) => {
    if (err !== null) {
      console.log(err);
    } else {
      res.send({ message: "Successfully Inserted" });
    }
  });
});

//Insert vet clinic log
app.post("/vetclinic/system/logs", (req, res) => {
  // console.log("Registered vet clinic");
  const name = req.body.name;
  const vet_status = req.body.vet_status;
  // console.log(name);
  var userLogs;
  if (vet_status == "Verified") {
    userLogs = name + " has been logged in as vet clinic";
  } else {
    userLogs = name + " has been logged in as unverified vet clinic";
  }

  const query =
    "INSERT INTO system_logs (logs_description,logs_type) VALUES (?,?)";
  db.query(query, [userLogs, 1], (err, result) => {
    if (err !== null) {
      console.log(err);
    } else {
      res.send({ message: "Successfully Inserted" });
    }
  });
});

//Insert system admin log
app.post("/systemAdmin/system/logs", (req, res) => {
  const name = req.body.name;
  var userLogs = name + " has been logged in as system admin";
  const query =
    "INSERT INTO system_logs (logs_description,logs_type) VALUES (?,?)";
  db.query(query, [userLogs, 1], (err, result) => {
    if (err !== null) {
      console.log(err);
    } else {
      res.send({ message: "Successfully Inserted" });
    }
  });
});

//REGISTER SYSTEM LOG

//Insert pet owner log
app.post("/pet_owner/register/system/logs", (req, res) => {
  // console.log("Registred");
  const name = req.body.name;
  var userLogs = name + " has been registered as petowner";
  var userLogss = name + " has been logged in as petowner";
  const query =
    "INSERT INTO system_logs (logs_description,logs_type) VALUES (?,?)";
  db.query(query, [userLogs, 2], (err, result) => {
    if (err !== null) {
      console.log(err);
    } else {
      db.query(query, [userLogss, 1], (err, result) => {
        if (err !== null) {
          console.log(err);
        } else {
          res.send({ message: "Successfully Inserted Login" });
        }
      });
    }
  });
});

//Insert vet clinic log
app.post("/vetclinic/register/system/logs", (req, res) => {
  console.log("Registred");
  const name = req.body.name;
  var userLogs = name + " has been registered as vet clinic";
  var userLogss = name + " has been logged in as unverified vet clinic";
  const query =
    "INSERT INTO system_logs (logs_description,logs_type) VALUES (?,?)";
  db.query(query, [userLogs, 2], (err, result) => {
    if (err !== null) {
      console.log(err);
    } else {
      // res.send({ message: "Successfully Inserted Registered" });
      db.query(query, [userLogss, 1], (err, result) => {
        if (err !== null) {
          console.log(err);
        } else {
          res.send({ message: "Successfully Inserted Login" });
        }
      });
    }
  });
});

//Insert system admin log
app.post("/systemAdmin/register/system/logs", (req, res) => {
  // console.log("Registred");
  const name = req.body.name;
  var userLogs = name + " has been registered as system admin";
  var userLogss = name + " has been logged in as system admin";
  const query =
    "INSERT INTO system_logs (logs_description,logs_type) VALUES (?,?)";
  db.query(query, [userLogs, 2], (err, result) => {
    if (err !== null) {
      console.log(err);
    } else {
      res.send({ message: "Successfully Inserted Registered" });
      // db.query(query, [userLogss, 1], (err, result) => {
      //   if (err !== null) {
      //     console.log(err);
      //   } else {
      //     res.send({ message: "Successfully Inserted Login" });
      //   }
      // });
    }
  });
});

//LOGOUT - SYSTEM LOG
//Insert pet owner log
app.post("/pet_owner/logout/system/logs", (req, res) => {
  const name = req.body.name;
  var userLogs = name + " has been logged out in as petowner";
  const query =
    "INSERT INTO system_logs (logs_description,logs_type) VALUES (?,?)";
  db.query(query, [userLogs, 3], (err, result) => {
    if (err !== null) {
      console.log(err);
    } else {
      res.send({ message: "Successfully Inserted" });
    }
  });
});

//Insert vet clinic log
app.post("/vetclinic/unverified/logout/system/logs", (req, res) => {
  const name = req.body.name;
  // const vet_status = req.body.vet_status;
  // console.log(name);
  var userLogs = name + " has been logged out as unverified vet clinic";

  const query =
    "INSERT INTO system_logs (logs_description,logs_type) VALUES (?,?)";
  db.query(query, [userLogs, 3], (err, result) => {
    if (err !== null) {
      console.log(err);
    } else {
      res.send({ message: "Successfully Inserted" });
    }
  });
});

app.post("/vetclinic/verified/logout/system/logs", (req, res) => {
  const name = req.body.name;
  const vet_status = req.body.vet_status;
  // console.log(name);
  var userLogs = name + " has been logged out as vet clinic";

  const query =
    "INSERT INTO system_logs (logs_description,logs_type) VALUES (?,?)";
  db.query(query, [userLogs, 3], (err, result) => {
    if (err !== null) {
      console.log(err);
    } else {
      res.send({ message: "Successfully Inserted" });
    }
  });
});

//Insert system admin log
app.post("/systemAdmin/logout/system/logs", (req, res) => {
  const name = req.body.name;
  var userLogs = name + " has been logged out as system admin";
  const query =
    "INSERT INTO system_logs (logs_description,logs_type) VALUES (?,?)";
  db.query(query, [userLogs, 3], (err, result) => {
    if (err !== null) {
      console.log(err);
    } else {
      res.send({ message: "Successfully Inserted" });
    }
  });
});

//System logs display
app.get("/systemAdmin/system/logs", (req, res) => {
  // console.log(pet_owner_id);

  const sqlQuery = "SELECT * FROM system_logs ORDER BY logs_id DESC";

  db.query(sqlQuery, (err, result) => {
    // console.log(result);

    res.send(result);
  });
});

//Forget pass System log for users
app.post("/forget/password/system/logs", (req, res) => {
  console.log("Change Password");
  const phoneNumber = req.body.phoneNumber;
  const user_role = req.body.user_role;

  var userLogs;
  if (user_role == 1) {
    userLogs = "Pet Owner with " + phoneNumber + " change his/her password ";
  } else if (user_role == 2) {
    userLogs = "Vet clinic with " + phoneNumber + " change their password";
  } else if (user_role == 3) {
    userLogs = "System admin with " + phoneNumber + " change his/her password";
  }

  const query =
    "INSERT INTO system_logs (logs_description,logs_type) VALUES (?,?)";
  db.query(query, [userLogs, 4], (err, result) => {
    if (err !== null) {
      console.log(err);
    } else {
      res.send({ message: "Successfully Inserted" });
    }
  });
});

//Get list of rates and feedback of specific vet
app.get("/vetRatings/vetclinic/list/:vetid", (req, res) => {
  // console.log(vetAdminId);
  const vetid = req.params.vetid;
  const sqlQuery =
    "SELECT pet_owners.name, pet_owners.profilePicture, services.service_name, rate_feedback.ratings, rate_feedback.comments ,appointment.date_scheduled, appointment.time_scheduled FROM rate_feedback JOIN appointment ON rate_feedback.appointment_id = appointment.appointment_id JOIN pet_owners ON pet_owners.pet_owner_id = appointment.pet_owner_id JOIN services ON services.service_id = appointment.service_id JOIN vet_clinic ON vet_clinic.vetid = services.vetid WHERE appointment.vetid= ? AND appointment.appointment_status= 'Done'";

  db.query(sqlQuery, vetid, (err, result) => {
    // var resultData = JSON.parse(JSON.stringify(result));
    // console.log(resultData[0]);
    res.send(result);
    // console.log(result)
  });
});

//Get immunization history of specific pet and vet
app.get("/pet/immunization/history/:vetid/:id", (req, res) => {
  // console.log(vetAdminId);
  const vetid = req.params.vetid;
  const id = req.params.id;
  // console.log(id);
  const sqlQuery =
    "SELECT * FROM appointment JOIN immunization_history ON appointment.appointment_id = immunization_history.appointment_id WHERE appointment.vetid = ? && immunization_history.pet_id= ? && appointment.appointment_status = 'Done'";

  db.query(sqlQuery, [vetid, id], (err, result) => {
    // var resultData = JSON.parse(JSON.stringify(result));
    res.send(result);
    // console.log(result);
  });
});

//Get immunization history of specific pet and pet owner
app.get("/petOwner/pet/immunization/history/:pet_owner_id/:id", (req, res) => {
  // console.log(vetAdminId);
  const pet_owner_id = req.params.pet_owner_id;
  const id = req.params.id;
  // console.log(id);
  const sqlQuery =
    "SELECT * FROM appointment JOIN immunization_history ON appointment.appointment_id = immunization_history.appointment_id WHERE appointment.pet_owner_id = ? && immunization_history.pet_id= ?";

  db.query(sqlQuery, [pet_owner_id, id], (err, result) => {
    // var resultData = JSON.parse(JSON.stringify(result));
    res.send(result);
    // console.log(result);
  });
});

// Get pet owner id using pet id
app.get("/get/user/id/:pet_id", (req, res) => {
  // console.log(vetAdminId);
  const pet_id = req.params.pet_id;

  const sqlQuery = "SELECT pet_owner_id FROM pets WHERE pet_id = ?";

  db.query(sqlQuery, pet_id, (err, result) => {
    // var resultData = JSON.parse(JSON.stringify(result));
    res.send(result);
    // console.log(result);
  });
});

//Notification isViewed update vet clinic
app.put("/vetclinic/notification/viewed/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  const sqlQuery =
    "UPDATE pet_owners JOIN appointment ON pet_owners.pet_owner_id = appointment.pet_owner_id JOIN notifications ON notifications.appointment_id = appointment.appointment_id JOIN services ON services.service_id = notifications.service_id JOIN vet_clinic ON vet_clinic.vetid = services.vetid SET notifications.isViewed = 1 WHERE vet_clinic.vetid = ? && notifications.status IN ('Done','Cancelled')";
  db.query(sqlQuery, vetid, (err, result) => {
    if (err === null) {
      res.send({ message: "Correct" });
    } else {
      console.log(err);
    }
  });
});

//Notification isNew update vet clinic
app.put("/vetclinic/notification/isNew/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  const sqlQuery =
    "UPDATE pet_owners JOIN appointment ON pet_owners.pet_owner_id = appointment.pet_owner_id JOIN notifications ON notifications.appointment_id = appointment.appointment_id JOIN services ON services.service_id = notifications.service_id JOIN vet_clinic ON vet_clinic.vetid = services.vetid SET notifications.isNew = 1 WHERE vet_clinic.vetid = ? && notifications.status IN ('Pending','Cancelled')";
  db.query(sqlQuery, vetid, (err, result) => {
    if (err === null) {
      res.send({ message: "Correct" });
    } else {
      console.log(err);
    }
  });
});

// Number of unviewed notif for vet clinic
app.get("/vetclinic/notification/length/:vetid", (req, res) => {
  // console.log(vetAdminId);
  const vetid = req.params.vetid;
  const sqlQuery =
    "SELECT * FROM notifications JOIN appointment ON notifications.appointment_id = appointment.appointment_id WHERE appointment.vetid = ? AND notifications.status  IN ('Done','Cancelled') AND notifications.isViewed = 0";

  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result.length);
    if (err == null) {
      res.send({ view: result.length });
    } else {
      console.log(err);
    }
  });
});

// Number of unviewed notif isNew for vet clinic
app.get("/vetclinic/notification/isNew/length/:vetid", (req, res) => {
  // console.log(vetAdminId);
  const vetid = req.params.vetid;
  // console.log(vetid);
  const sqlQuery =
    "SELECT * FROM notifications JOIN appointment ON notifications.appointment_id = appointment.appointment_id WHERE appointment.vetid = ? AND notifications.status  IN ('Pending','Cancelled') AND notifications.isNew = 0";

  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result.length);
    if (err == null) {
      res.send({ view: result.length });
    } else {
      console.log(err);
    }
  });
});

//Notification isViewed update pet owner
app.put("/petOwner/notification/viewed/:pet_owner_id", (req, res) => {
  const pet_owner_id = req.params.pet_owner_id;
  const sqlQuery =
    "UPDATE pet_owners JOIN appointment ON pet_owners.pet_owner_id = appointment.pet_owner_id JOIN notifications ON notifications.appointment_id = appointment.appointment_id JOIN services ON services.service_id = notifications.service_id JOIN vet_clinic ON vet_clinic.vetid = services.vetid SET notifications.isViewed = 1 WHERE pet_owners.pet_owner_id = ? AND NOT notifications.status = 'Pending'";
  db.query(sqlQuery, pet_owner_id, (err, result) => {
    if (err === null) {
      res.send({ message: "Correct" });
    } else {
      console.log(err);
    }
  });
});

//Notification isNew update pet owner
app.put("/petOwner/notification/isNew/:pet_owner_id", (req, res) => {
  const pet_owner_id = req.params.pet_owner_id;
  const sqlQuery =
    "UPDATE pet_owners JOIN appointment ON pet_owners.pet_owner_id = appointment.pet_owner_id JOIN notifications ON notifications.appointment_id = appointment.appointment_id JOIN services ON services.service_id = notifications.service_id JOIN vet_clinic ON vet_clinic.vetid = services.vetid SET notifications.isNew = 1 WHERE pet_owners.pet_owner_id = ? AND NOT notifications.status = 'Pending'";
  db.query(sqlQuery, pet_owner_id, (err, result) => {
    if (err === null) {
      res.send({ message: "Correct" });
    } else {
      console.log(err);
    }
  });
});

// Number of unviewed notif for pet owner
app.get("/petOwner/notification/length/:pet_owner_id", (req, res) => {
  // console.log(vetAdminId);
  const pet_owner_id = req.params.pet_owner_id;
  // console.log(vetid);
  const sqlQuery =
    "SELECT * FROM notifications JOIN appointment ON notifications.appointment_id = appointment.appointment_id WHERE appointment.pet_owner_id = ? AND notifications.isViewed = 0 AND NOT notifications.status = 'Pending'";

  db.query(sqlQuery, pet_owner_id, (err, result) => {
    // console.log(result.length);
    if (err == null) {
      res.send({ view: result.length });
    } else {
      console.log(err);
    }
  });
});

// Number of unviewed notif for pet owner isNew
app.get("/petOwner/notification/isNew/length/:pet_owner_id", (req, res) => {
  // console.log(vetAdminId);
  const pet_owner_id = req.params.pet_owner_id;
  // console.log(vetid);
  const sqlQuery =
    "SELECT * FROM notifications JOIN appointment ON notifications.appointment_id = appointment.appointment_id WHERE appointment.pet_owner_id = ? AND notifications.isNew = 0 AND notifications.status IN ('Done', 'Approved') ";

  db.query(sqlQuery, pet_owner_id, (err, result) => {
    // console.log(result.length);
    if (err == null) {
      res.send({ view: result.length });
    } else {
      console.log(err);
    }
  });
});

//Get the latest entry of appointment
app.get("/get/latest/entry/appointment/:pet_owner_id/:vetid", (req, res) => {
  // console.log(vetAdminId);

  const pet_owner_id = req.params.pet_owner_id;
  const vetid = req.params.vetid;
  // console.log(pet_owner_id);
  // console.log(vetid);
  const sqlQuery =
    "SELECT MAX(appointment.appointment_id) AS latestId FROM pet_owners JOIN appointment ON pet_owners.pet_owner_id = appointment.pet_owner_id JOIN vet_clinic ON vet_clinic.vetid = appointment.vetid WHERE pet_owners.pet_owner_id = ? AND vet_clinic.vetid= ?";

  db.query(sqlQuery, [pet_owner_id, vetid], (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//Get the latest entry of reserved
app.get("/get/latest/entry/reserved/:pet_owner_id/:vetid", (req, res) => {
  console.log("Getting last entry in reservation");

  const pet_owner_id = req.params.pet_owner_id;
  const vetid = req.params.vetid;
  // console.log(pet_owner_id);
  // console.log(vetid);
  const sqlQuery =
    "SELECT MAX(reservation.reserve_id) AS latestId FROM pet_owners JOIN reservation ON pet_owners.pet_owner_id = reservation.pet_owner_id JOIN vet_clinic ON vet_clinic.vetid = reservation.vetid WHERE pet_owners.pet_owner_id = ? AND vet_clinic.vetid= ?";

  db.query(sqlQuery, [pet_owner_id, vetid], (err, result) => {
    console.log(result);
    res.send(result);
  });
});

//Pet owner CANCEL appointment
app.put("/petowner/appointment/cancel/:appointment_id", (req, res) => {
  const appointment_id = req.params.appointment_id;
  // console.log(appointment_id);
  const sqlQuery =
    "UPDATE appointment SET appointment_status = 'Cancelled' WHERE appointment_id = ? ";
  db.query(sqlQuery, appointment_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//Reservation notif product

//Insert notif reserved product
app.post("/notification/reserved/pending", (req, res) => {
  const order_id = req.body.order_id;
  // console.log(reserve_id);
  // console.log(product_id);
  // console.log(status);
  const sqlQuery = `INSERT INTO notification_reservation (order_id,status) VALUES (?,?)`;
  db.query(sqlQuery, [order_id, "Pending"], (err, result) => {
    console.log("Reserved Notification");
    console.log(err);
    res.send({ message: "Reserved Notification" });
  });
});

app.post("/notification/reserved/purchased", (req, res) => {
  const order_id = req.body.order_id;
  const status = req.body.status;
  const sqlQuery = `INSERT INTO notification_reservation (status, order_id) VALUES (?,?)`;
  db.query(sqlQuery, [status, order_id], (err, result) => {
    console.log("Reserved Notification");
    console.log(err);
    res.send({ message: "Reserved Notification" });
  });
});

//Insert notif reserved product cancelled
app.post("/notification/reserved/cancelled", (req, res) => {
  const order_id = req.body.order_id;
  const product_id = req.body.product_id;

  const sqlQuery = `INSERT INTO notification_reservation (order_id,product_id,status) VALUES (?,?,?)`;
  db.query(sqlQuery, [order_id, product_id, "Cancelled"], (err, result) => {
    console.log(result);
    res.send({ message: "Reserved Notification" });
  });
});

app.post("/notification/reserved/expired", (req, res) => {
  const order_id = req.body.order_id;
  const status = req.body.status;

  const sqlQuery = `INSERT INTO notification_reservation (status, order_id) VALUES (?,?,?)`;
  db.query(sqlQuery, [status, order_id], (err, result) => {
    console.log(result);
    res.send({ message: "Reserved Notification" });
  });
});

//Insert notif reserved product cancelled
app.post("/notification/reserved/done", (req, res) => {
  const reserve_id = req.body.reserve_id;
  const product_id = req.body.product_id;
  const status = req.body.status;

  const sqlQuery = `INSERT INTO notification_reservation (reserve_id,product_id,status) VALUES (?,?,?)`;
  db.query(sqlQuery, [reserve_id, product_id, status], (err, result) => {
    console.log(result);
    res.send({ message: "Reserved Notification" });
  });
});

//Display reservation notif for pet owner
app.get("/petOwner/notification/reservation/:pet_owner_id", (req, res) => {
  const pet_owner_id = req.params.pet_owner_id;
  console.log(pet_owner_id);
  const sqlQuery =
    "SELECT * FROM  vet_clinic JOIN reservation ON vet_clinic.vetid = reservation.vetid JOIN notification_reservation ON notification_reservation.order_id = reservation.order_id WHERE reservation.pet_owner_id= ? AND notification_reservation.status IN ('Purchased', 'Expired') ORDER BY notification_reservation.date_time_created DESC";
  db.query(sqlQuery, pet_owner_id, (err, result) => {
    console.log(result);
    res.send(result);
  });
});

//Notification reservation isViewed update pet owner
app.put(
  "/petOwner/notification/reservation/viewed/:pet_owner_id",
  (req, res) => {
    const pet_owner_id = req.params.pet_owner_id;
    const sqlQuery =
      "UPDATE pet_owners JOIN reservation ON pet_owners.pet_owner_id = reservation.pet_owner_id JOIN notification_reservation ON notification_reservation.order_id = reservation.order_id SET notification_reservation.isViewed = 1 WHERE pet_owners.pet_owner_id = ? AND NOT notification_reservation.status IN ( 'Pending', 'Cancelled')";
    db.query(sqlQuery, pet_owner_id, (err, result) => {
      if (err === null) {
        res.send({ message: "Correct" });
      } else {
        console.log(err);
      }
    });
  }
);

//Notification reservation isNew update pet owner
app.put(
  "/petOwner/notification/reservation/isNew/:pet_owner_id",
  (req, res) => {
    const pet_owner_id = req.params.pet_owner_id;
    const sqlQuery =
      "UPDATE pet_owners JOIN reservation ON pet_owners.pet_owner_id = reservation.pet_owner_id JOIN notification_reservation ON notification_reservation.reserve_id = reservation.reserve_id JOIN products ON products.product_id = notification_reservation.product_id JOIN vet_clinic ON vet_clinic.vetid = products.vetid SET notification_reservation.isNew = 1 WHERE pet_owners.pet_owner_id = ? AND notification_reservation.status = 'Purchased'";
    db.query(sqlQuery, pet_owner_id, (err, result) => {
      if (err === null) {
        res.send({ message: "Correct" });
      } else {
        console.log(err);
      }
    });
  }
);

// Number of unviewed reservation notif for pet owner
app.get(
  "/petOwner/notification/reservation/length/:pet_owner_id",
  (req, res) => {
    // console.log(vetAdminId);
    const pet_owner_id = req.params.pet_owner_id;
    // console.log(vetid);
    const sqlQuery =
      "SELECT * FROM notification_reservation JOIN reservation ON notification_reservation.order_id = reservation.order_id WHERE reservation.pet_owner_id = ? AND notification_reservation.isViewed = 0 AND notification_reservation.status = 'Purchased'";

    db.query(sqlQuery, pet_owner_id, (err, result) => {
      // console.log(result.length);
      if (err == null) {
        res.send({ view: result.length });
      } else {
        console.log(err);
      }
    });
  }
);

// Number of unviewed reservation notif for pet owner isNew
app.get(
  "/petOwner/notification/reservation/isNew/length/:pet_owner_id",
  (req, res) => {
    // console.log(vetAdminId);
    const pet_owner_id = req.params.pet_owner_id;
    // console.log(vetid);
    const sqlQuery =
      "SELECT * FROM notification_reservation JOIN reservation ON notification_reservation.reserve_id = reservation.reserve_id WHERE reservation.pet_owner_id = ? AND notification_reservation.isNew = 0 AND notification_reservation.status = 'Purchased'";

    db.query(sqlQuery, pet_owner_id, (err, result) => {
      // console.log(result.length);
      if (err == null) {
        res.send({ view: result.length });
      } else {
        console.log(err);
      }
    });
  }
);

//Display reservation notif for vet clinic
app.get("/vetclinic/notification/reservation/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(pet_owner_id);
  const sqlQuery =
    "SELECT * FROM pet_owners JOIN reservation ON pet_owners.pet_owner_id = reservation.pet_owner_id JOIN notification_reservation ON notification_reservation.order_id = reservation.order_id JOIN vet_clinic ON vet_clinic.vetid = reservation.vetid WHERE vet_clinic.vetid = ? && notification_reservation.status IN ('Pending', 'Cancelled')  ORDER BY notification_reservation.date_time_created DESC";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//Notification isViewed update vet clinic
app.put("/vetclinic/notification/reservation/viewed/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  const sqlQuery =
    "UPDATE vet_clinic JOIN reservation ON vet_clinic.vetid = reservation.vetid JOIN notification_reservation ON notification_reservation.order_id = reservation.order_id SET notification_reservation.isViewed = 1 WHERE vet_clinic.vetid = ? AND NOT notification_reservation.status IN ( 'Purchased', 'Expired')";
  db.query(sqlQuery, vetid, (err, result) => {
    if (err === null) {
      res.send({ message: "Correct" });
    } else {
      console.log(err);
    }
  });
});

//Notification isNew update vet clinic
// app.put("/vetclinic/notification/reservation/isNew/:vetid", (req, res) => {
//   const vetid = req.params.vetid;
//   const sqlQuery =
//     "UPDATE pet_owners JOIN reservation ON pet_owners.pet_owner_id = reservation.pet_owner_id JOIN notification_reservation ON notification_reservation.reserve_id = reservation.reserve_id JOIN products ON products.product_id = notification_reservation.product_id JOIN vet_clinic ON vet_clinic.vetid = products.vetid SET notification_reservation.isNew = 1 WHERE vet_clinic.vetid = ? AND NOT notification_reservation.status = 'Purchased'";
//   db.query(sqlQuery, vetid, (err, result) => {
//     if (err === null) {
//       res.send({ message: "Correct" });
//     } else {
//       console.log(err);
//     }
//   });
// });

// Number of unviewed notif for vet clinic
app.get("/vetclinic/notification/reservation/length/:vetid", (req, res) => {
  // console.log(vetAdminId);
  const vetid = req.params.vetid;
  // console.log(vetid);
  const sqlQuery =
    "SELECT * FROM notification_reservation JOIN reservation ON notification_reservation.order_id= reservation.order_id WHERE reservation.vetid = ? AND notification_reservation.isViewed = 0 AND NOT notification_reservation.status IN  ('Purchased', 'Expired')";

  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result.length);
    if (err == null) {
      res.send({ view: result.length });
    } else {
      console.log(err);
    }
  });
});

// Number of unviewed notif for vet clinic
// app.get(
//   "/vetclinic/notification/reservation/isNew/length/:vetid",
//   (req, res) => {
//     // console.log(vetAdminId);
//     const vetid = req.params.vetid;
//     // console.log(vetid);
//     const sqlQuery =
//       "SELECT * FROM notification_reservation JOIN reservation ON notification_reservation.reserve_id = reservation.reserve_id WHERE reservation.vetid = ? AND notification_reservation.isNew = 0 AND NOT notification_reservation.status = 'Purchased'";

//     db.query(sqlQuery, vetid, (err, result) => {
//       // console.log(result.length);
//       if (err == null) {
//         res.send({ view: result.length });
//       } else {
//         console.log(err);
//       }
//     });
//   }
// );

//Display all service completed in every pet in health card
// Number of unviewed notif for vet clinic
app.get("/petOwner/services/health/card/:pet_id", (req, res) => {
  // console.log(vetAdminId);
  const pet_id = req.params.pet_id;
  // console.log(vetid);
  const sqlQuery =
    "SELECT pet_owners.name, pets.pet_name, services.service_name, services.service_description, vet_clinic.vet_name, services.category, appointment.date_accomplished FROM pet_owners JOIN pets ON pet_owners.pet_owner_id = pets.pet_owner_id JOIN appointment ON appointment.pet_id = pets.pet_id JOIN services ON services.service_id = appointment.service_id JOIN vet_clinic ON vet_clinic.vetid = services.vetid WHERE pets.pet_id = ? AND appointment.appointment_status= 'Done'";

  db.query(sqlQuery, pet_id, (err, result) => {
    // console.log(result);
    if (err == null) {
      res.send(result);
    } else {
      console.log(err);
    }
  });
});

//notification for messages

//pet owner
app.put("/petOwner/messages/notification/:pet_owner_id", (req, res) => {
  const pet_owner_id = req.params.pet_owner_id;
  const sqlQuery =
    "UPDATE messages SET isNewMessagePet = 1 WHERE messages.pet_owner_id = ? AND messages.user_message = 2";
  db.query(sqlQuery, pet_owner_id, (err, result) => {
    if (err === null) {
      res.send({ message: "Viewed" });
    } else {
      console.log(err);
    }
  });
});

app.get("/petOwner/messages/notification/length/:pet_owner_id", (req, res) => {
  // console.log(vetAdminId);
  const pet_owner_id = req.params.pet_owner_id;
  // console.log(vetid);
  const sqlQuery =
    "SELECT * FROM messages WHERE messages.pet_owner_id = ? AND messages.isNewMessagePet = 0 AND messages.user_message = 2";

  db.query(sqlQuery, pet_owner_id, (err, result) => {
    // console.log(result.length);
    if (err == null) {
      res.send({ view: result.length });
    } else {
      console.log(err);
    }
  });
});

//vet clinic

app.put("/vetclinic/messages/notification/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  const sqlQuery =
    "UPDATE messages SET isNewMessageVet = 1 WHERE messages.vetid = ? AND messages.user_message = 1";
  db.query(sqlQuery, vetid, (err, result) => {
    if (err === null) {
      res.send({ message: "viewed" });
    } else {
      console.log(err);
    }
  });
});

// Verify Email
app.post("/emailChecker", (req, res) => {
  const email = req.body.email;

  db.query("SELECT * from user_role WHERE email = ?", email, (err, result) => {
    if (err == null) {
      if (result.length != 0) {
        res.send(true);
      } else {
        res.send(false);
      }
    } else {
      console.log(err);
    }
  });
});

// Email verification vet administrator
app.get(`/verify/vetadmin/:email`, (req, res) => {
  db.query(
    "UPDATE vet_clinic SET isEmailVerify = true where email = ?",
    req.params.email,
    (err, result) => {
      if (err == null) {
        res.send("Email Verified");
      } else {
        console.log(err);
      }
    }
  );
});

// Email verification veterinarian
app.get(`/verify/veterinarian/:email`, (req, res) => {
  db.query(
    "UPDATE vet_doctors SET isVerified = true where vet_doc_email = ?",
    req.params.email,
    (err, result) => {
      if (err == null) {
        res.send("Email Verified");
      } else {
        console.log(err);
      }
    }
  );
});

// Email verification vet staff
app.get(`/verify/vetStaff/:email`, (req, res) => {
  db.query(
    "UPDATE vet_staff SET isVerified = true where vet_staff_email = ?",
    req.params.email,
    (err, result) => {
      if (err == null) {
        res.send("Email Verified");
      } else {
        console.log(err);
      }
    }
  );
});

// Send email vet administrator
app.post("/verifyEmail/vetadmin", async (req, res) => {
  const hostUrl = req.body.hostUrl;
  const email = req.body.email;
  console.log(email);
  const verificationCode = Math.floor(Math.random() * (9999 - 1000 + 1) + 1000);
  var transporter = nodemailer.createTransport({
    service: "yahoo",
    auth: {
      user: "terravetinc@yahoo.com",
      pass: "yxftzwvsmltbnmii",
    },
  });

  var mailOptions = {
    from: "terravetinc@yahoo.com",
    to: email,
    subject: " TerraVet Account Verification",
    text: `Thank you for choosing terravet, ${email}! To verify your account, kindly click the link within this email ${`${hostUrl}/verify/vetadmin/${email}`}.`,
  };

  await transporter.sendMail(mailOptions, function (error, info) {
    if (error) {
      console.log(error);
      res.send("error");
    } else {
      res.send("Success");
    }
  });
});

// Send email veterinarian
app.post("/verifyEmail", async (req, res) => {
  const hostUrl = req.body.hostUrl;
  const email = req.body.email;
  console.log(email);
  const verificationCode = Math.floor(Math.random() * (9999 - 1000 + 1) + 1000);
  var transporter = nodemailer.createTransport({
    service: "yahoo",
    auth: {
      user: "terravetinc@yahoo.com",
      pass: "yxftzwvsmltbnmii",
    },
  });

  var mailOptions = {
    from: "terravetinc@yahoo.com",
    to: email,
    subject: " TerraVet Account Verification",
    text: `Thank you for choosing terravet, ${email}! To verify your account, kindly click the link within this email ${`${hostUrl}/verify/veterinarian/${email}`}.`,
  };

  await transporter.sendMail(mailOptions, function (error, info) {
    if (error) {
      console.log(error);
      res.send("error");
    } else {
      res.send("Success");
    }
  });
});

// Send email vet staff
app.post("/verifyEmail/vetStaff", async (req, res) => {
  const hostUrl = req.body.hostUrl;
  const email = req.body.email;
  console.log(email);
  var transporter = nodemailer.createTransport({
    service: "yahoo",
    auth: {
      user: "terravetinc@yahoo.com",
      pass: "yxftzwvsmltbnmii",
    },
  });

  var mailOptions = {
    from: "terravetinc@yahoo.com",
    to: email,
    subject: " TerraVet Account Verification",
    text: `Thank you for choosing terravet, ${email}! To verify your account, kindly click the link within this email ${`${hostUrl}/verify/vetStaff/${email}`}.`,
  };

  await transporter.sendMail(mailOptions, function (error, info) {
    if (error) {
      console.log(error);
      res.send("error");
    } else {
      res.send("Success");
    }
  });
});

// app.post("/verifyEmail/submit", (req, res) => {
//   const email = req.body.email;
//   const verificationCode = req.body.verificationCode;
//   console.log(verificationCode);

//   db.query(
//     "SELECT * FROM email_verification WHERE email = ? AND verification_code = ?",
//     [email, verificationCode],
//     (err, result) => {
//       if (result.length > 0) {
//         res.send("Email Verified");
//       } else {
//         res.send("Wrong verification code");
//       }
//     }
//   );
// });

//registration veterinarian
app.post("/register/veterinarian", (req, res) => {
  const vetid = req.body.vetid;
  const email = req.body.email;
  const password = req.body.password;
  const fName = req.body.fName;
  const lName = req.body.lName;
  const gender = req.body.gender;
  const contactNumber = req.body.contactNumber;

  db.query(
    "INSERT INTO user_role (email,userrole,phone_number) VALUES (?,?,?)",
    [email, 4, contactNumber],
    (err, result) => {
      if (err == null) {
        bcrypt.hash(password, saltRounds, (err, hash) => {
          if (err) {
            console.log(err);
          }

          db.query(
            "INSERT INTO vet_doctors (vetid,vet_doc_fname,vet_doc_lname,vet_doc_contactNumber,vet_doc_email, vet_doc_password ,vet_doc_gender) VALUES (?,?,?,?,?,?,?)",
            [vetid, fName, lName, contactNumber, email, hash, gender],
            (err, result) => {
              if (err == null) {
                console.log("vet doctor successfully register");
                res.send("Successfully Registered");
              } else {
                console.log(err);
                res.send("Not Successfully Registered");
              }
            }
          );
        });
      } else {
        console.log(err);
      }
    }
  );
});

// registration vet staff
app.post("/register/vetStaff", (req, res) => {
  const vetid = req.body.vetid;
  const email = req.body.email;
  const password = req.body.password;
  const fName = req.body.fName;
  const lName = req.body.lName;
  const contactNumber = req.body.contactNumber;

  db.query(
    "INSERT INTO user_role (email,userrole,phone_number) VALUES (?,?,?)",
    [email, 5, contactNumber],
    (err, result) => {
      if (err == null) {
        bcrypt.hash(password, saltRounds, (err, hash) => {
          if (err) {
            console.log(err);
          }
          db.query(
            "INSERT INTO vet_staff (vetid,vet_staff_fname,vet_staff_lname,vet_staff_contactNumber,vet_staff_email, vet_staff_password) VALUES (?,?,?,?,?,?)",
            [vetid, fName, lName, contactNumber, email, hash],
            (err, result) => {
              if (err == null) {
                console.log("vet staff successfully register");
                res.send("Successfully Registered");
              } else {
                console.log(err);
                res.send("Not Successfully Registered");
              }
            }
          );
        });
      } else {
        console.log(err);
      }
    }
  );
});

app.get("/vetclinic/messages/notification/length/:vetid", (req, res) => {
  // console.log(vetAdminId);
  // const vetid = req.params.vetid;
  // // console.log(vetid);
  // const sqlQuery =
  //   "SELECT * FROM messages WHERE messages.vetid = ? AND messages.isNewMessageVet = 0 AND messages.user_message = 1";
  // db.query(sqlQuery, vetid, (err, result) => {
  //   // console.log(result.length);
  //   if (err == null) {
  //     res.send({ view: result.length });
  //   } else {
  //     console.log(err);
  //   }
  // });
});

//vet staff
//Product
app.get("/products/staff/:vet_staff_id", (req, res) => {
  const vet_staff_id = req.params.vet_staff_id;
  // console.log(vet_admin_id);
  const sqlQuery =
    "SELECT * FROM products INNER JOIN vet_clinic ON products.vetid = vet_clinic.vetid INNER JOIN vet_staff ON vet_staff.vetid = vet_clinic.vetid WHERE vet_staff_id = ?";
  db.query(sqlQuery, vet_staff_id, (err, result) => {
    console.log(result);
    res.send(result);
  });
});

//Reservation
app.get("/pending/reservation/staff/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(pet_owner_id);
  const sqlQuery =
    "SELECT * FROM vet_clinic JOIN products ON vet_clinic.vetid = products.vetid JOIN reservation ON reservation.product_id= products.product_id JOIN pet_owners ON pet_owners.pet_owner_id = reservation.pet_owner_id JOIN pets ON pets.pet_owner_id = pet_owners.pet_owner_id WHERE reservation.vetid = ? AND reservation.reservation_status='Pending' ORDER BY reservation.reserve_id DESC";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

app.get("/pending/appointment/staff/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(pet_owner_id);
  const sqlQuery =
    "SELECT * FROM vet_clinic JOIN products ON vet_clinic.vetid = products.vetid JOIN reservation ON reservation.product_id= products.product_id JOIN pet_owners ON pet_owners.pet_owner_id = reservation.pet_owner_id JOIN pets ON pets.pet_owner_id = pet_owners.pet_owner_id WHERE reservation.vetid = ? AND reservation.reservation_status='Pending' ORDER BY reservation.reserve_id DESC";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

app.get("/history/reservation/staff/:vet_staff_id", (req, res) => {
  const vet_staff_id = req.params.vet_staff_id;
  // console.log(pet_owner_id);
  const sqlQuery =
    "SELECT * FROM vet_staff JOIN vet_clinic ON vet_staff.vetid = vet_clinic.vetid JOIN products ON vet_clinic.vetid = products.vetid JOIN reservation ON reservation.product_id= products.product_id JOIN pet_owners ON pet_owners.pet_owner_id = reservation.pet_owner_id WHERE vet_staff.vet_staff_id = ? AND NOT reservation.reservation_status='Pending' ORDER BY reservation.reserve_id DESC";
  db.query(sqlQuery, vet_staff_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//pharmacy
app.get("/pharmacy/staff/:vet_staff_id", (req, res) => {
  const vet_id = req.params.vetid;
  const sqlQuery =
    "SELECT * FROM vet_staff JOIN vet_clinic ON vet_staff.vetid = vet_clinic.vetid  JOIN pharmacy ON pharmacy.vetid = vet_clinic.vetid WHERE vet_staff.vetid = ?";
  db.query(sqlQuery, vet_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//visitor monitoring
app.get("/visitor/staff/:vet_staff_id", (req, res) => {
  const vet_staff_id = req.params.vet_staff_id;
  // console.log(service_id)
  const sqlQuery =
    "SELECT * FROM pet_owners JOIN visitor_monitoring ON pet_owners.pet_owner_id = visitor_monitoring.pet_owner_id JOIN vet_clinic ON vet_clinic.vetid = visitor_monitoring.vetid JOIN vet_staff ON vet_staff.vetid = vet_clinic.vetid WHERE vet_staff.vet_staff_id = ? ";
  db.query(sqlQuery, vet_staff_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//vet doctor
// const vetid = req.params.vetid;
// // console.log(vetid);
// const sqlQuery =
//   "SELECT * FROM messages WHERE messages.vetid = ? AND messages.user_message = 1";

// // "SELECT * FROM messages WHERE messages.vetid = ? AND messages.isNewMessageVet = 0 AND messages.user_message = 1";

// db.query(sqlQuery, vetid, (err, result) => {
//   // console.log(result.length);
//   if (err == null) {
//     res.send({ view: result.length });
//   } else {
//     console.log(err);
//   }
// });

app.get("/vetclinic/get/veterinarian/:vetid", (req, res) => {
  const vetid = req.params.vetid;

  db.query(
    "SELECT * FROM vet_doctors WHERE vetid = ?",
    vetid,
    (err, result) => {
      if (err == null) {
        res.send(result);
      } else {
        console.log(err);
      }
    }
  );
});

app.get("/vetclinic/get/vetStaff/:vetid", (req, res) => {
  const vetid = req.params.vetid;

  db.query("SELECT * FROM vet_staff WHERE vetid = ?", vetid, (err, result) => {
    if (err == null) {
      res.send(result);
    } else {
      console.log(err);
    }
  });
});

//vet staff join vet clinic
app.get("/staff/:vet_staff_id", (req, res) => {
  const vet_staff_id = req.params.vet_staff_id;
  // console.log(pet_owner_id);
  const sqlQuery =
    "SELECT * FROM vet_staff JOIN vet_clinic ON vet_staff.vetid = vet_clinic.vetid WHERE vet_staff.vet_staff_id = ?";
  db.query(sqlQuery, vet_staff_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//vet doctor join vetclinic
app.get("/doc/:vet_doc_id", (req, res) => {
  const vet_doc_id = req.params.vet_doc_id;
  // console.log(vet_doc_id);
  const sqlQuery =
    "SELECT * FROM vet_doctors JOIN vet_clinic ON vet_doctors.vetid = vet_clinic.vetid WHERE vet_doctors.vet_doc_id = ?";
  db.query(sqlQuery, vet_doc_id, (err, result) => {
    res.send(result);
  });
});

//consultation pending
app.get("/doc/pending/appointment/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(vetid)
  const sqlQuery =
    "SELECT * FROM pet_owners JOIN pets ON pet_owners.pet_owner_id = pets.pet_owner_id JOIN appointment ON appointment.pet_id = pets.pet_id JOIN consultation ON consultation.appointment_id = appointment.appointment_id JOIN services ON services.service_id = consultation.service_id JOIN vet_clinic ON vet_clinic.vetid = services.vetid WHERE appointment.vetid = ? AND appointment.appointment_status='Done' AND services.category= 'Consultation'AND consultation.findings IS NULL AND consultation.prescription IS NULL ORDER BY appointment.appointment_id DESC";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

app.get("/doc/history/appointment/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(vetid)
  const sqlQuery =
    "SELECT * FROM pet_owners JOIN pets ON pet_owners.pet_owner_id = pets.pet_owner_id JOIN appointment ON appointment.pet_id = pets.pet_id JOIN consultation ON consultation.appointment_id= appointment.appointment_id JOIN services ON services.service_id = consultation.service_id JOIN vet_clinic ON vet_clinic.vetid = services.vetid WHERE appointment.vetid = ? AND appointment.appointment_status='Done' AND services.category = 'Consultation' ORDER BY appointment.appointment_id DESC";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

app.get("/doc/pets/appointment/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(vetid)
  const sqlQuery =
    "SELECT * FROM pet_owners JOIN pets ON pet_owners.pet_owner_id = pets.pet_owner_id JOIN appointment ON appointment.pet_id = pets.pet_id JOIN services ON services.service_id = appointment.service_id WHERE appointment.vetid = ? AND appointment.appointment_status='Approved' AND services.category= 'Pet Grooming' ORDER BY appointment.appointment_id DESC";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

app.get("/doc/pets/vaccination/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(vetid)
  const sqlQuery =
    "SELECT * FROM pet_owners JOIN pets ON pet_owners.pet_owner_id = pets.pet_owner_id JOIN immunization_history ON immunization_history.pet_id = pets.pet_id JOIN appointment ON appointment.appointment_id = immunization_history.appointment_id JOIN services ON services.service_id = appointment.service_id WHERE appointment.vetid = ? AND appointment.appointment_status='Done' AND services.category= 'Vaccination'AND immunization_history.prescription IS NULL ORDER BY appointment.appointment_id DESC";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

app.get("/doc/pets/examination/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(vetid);
  const sqlQuery =
    "SELECT * FROM pet_owners JOIN pets ON pet_owners.pet_owner_id = pets.pet_owner_id JOIN appointment ON appointment.pet_id = pets.pet_id JOIN medical_history ON medical_history.appointment_id = appointment.appointment_id JOIN services ON services.service_id = medical_history.service_id JOIN vet_clinic ON vet_clinic.vetid = services.vetid WHERE appointment.vetid = ? AND appointment.appointment_status='Done' AND services.category IN ('Pet Examination','Preventive Controls') AND medical_history.findings IS NULL AND medical_history.prescription IS NULL ORDER BY appointment.appointment_id DESC";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

app.get("/doc/pets/:petid", (req, res) => {
  const petid = req.params.petid;
  // console.log(petid);
  const sqlQuery = "SELECT * FROM pets WHERE pet_id = ?";
  db.query(sqlQuery, petid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//new petwoner checkout api
app.get("/petowner/check/reservedid/:orderid", (req, res) => {
  const orderid = req.params.orderid;
  // console.log(petid);
  const sqlQuery = "SELECT order_id FROM reservation WHERE order_id = ? ";
  db.query(sqlQuery, orderid, (err, result) => {
    // console.log(result);
    // res.send(result);
    if (result > 0) {
      res.send("Order id exist");
    } else {
      res.send("Order id not exist");
    }
  });
});

///for

///new api for post order id
app.post("/petowner/checkout/:petowner_id", (req, res) => {
  const petowner_id = req.params.petowner_id;
  const vet_id = req.body.vetid;
  var date = new Date();
  date.setHours(date.getHours() + 8);
  var isodate = date.toISOString();

  var order_id = Math.random().toString(36).slice(2);
  console.log(vet_id);
  db.query(
    "INSERT INTO reservation (order_id, pet_owner_id, vetid, reservation_status, date_reserve) VALUES (?,?,?,?,?);",
    [order_id, petowner_id, vet_id, "Pending", isodate],
    (err, result) => {
      if (err === null) {
        res.send({ message: "Successfull", orderId: order_id });
      } else {
        console.log(err);
      }
    }
  );
});

///new API insert product Reservation
app.post("/petowners/InsertProduct/:orderid", (req, res) => {
  const orderid = req.params.orderid;
  const product_id = req.body.productId;
  const product_quantity = req.body.quantity;

  console.log(product_id);

  db.query(
    "INSERT INTO reservation_products (order_id, product_id, res_quantity) VALUES (?,?,?);",
    [orderid, product_id, product_quantity],
    (err, result) => {
      if (err === null) {
        res.send({ message: "Successfull" });
      } else {
        console.log(err);
      }
    }
  );
});

app.get("/petowner/order/:pet_owner_id", (req, res) => {
  const pet_owner_id = req.params.pet_owner_id;
  // console.log(petid);
  console.log(pet_owner_id);
  const sqlQuery =
    "SELECT * FROM reservation JOIN vet_clinic ON reservation.vetid = vet_clinic.vetid WHERE reservation.pet_owner_id = ? AND reservation_status = 'Pending'";
  db.query(sqlQuery, pet_owner_id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

app.get("/petowner/order/products/:orderId", (req, res) => {
  const order_id = req.params.orderId;
  console.log(order_id);
  const sqlQuery =
    "SELECT * FROM reservation_products JOIN products ON reservation_products.product_id = products.product_id WHERE order_id = ?";
  db.query(sqlQuery, order_id, (err, result) => {
    console.log(result);
    res.send(result);
  });
});

//cancelled
app.put("/petowner/reservation/cancelled/:reservationId", (req, res) => {
  const reservation_id = req.params.reservationId;
  var date = new Date();
  date.setHours(date.getHours() + 8);
  var isodate = date.toISOString();
  console.log(reservation_id);
  // console.log(isodate);
  const sqlQuery =
    "UPDATE reservation SET reservation_status = ? , date_accomplished = ? WHERE order_id = ?";
  db.query(sqlQuery, ["Cancelled", isodate, reservation_id], (err, result) => {
    if (err == null) {
      res.send("Success");
    } else {
      console.log(err);
    }
  });
});

app.get("/petowner/order/history/:pet_owner_id", (req, res) => {
  const petownerid = req.params.pet_owner_id;
  console.log(petownerid);
  const sqlQuery =
    "SELECT * FROM reservation WHERE pet_owner_id = ? AND reservation_status = ?";
  db.query(sqlQuery, [petownerid, "Done"], (err, result) => {
    res.send(result);
  });
});

//staff new reservation api
app.get("/staff/pending/order/reservation/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(pet_owner_id);
  const sqlQuery =
    "SELECT * FROM reservation JOIN pet_owners ON reservation.pet_owner_id = pet_owners.pet_owner_id WHERE reservation.vetid = ? AND reservation.reservation_status = 'Pending' ORDER BY reservation.reserve_id DESC";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log("reserrrveeeee");
    res.send(result);
  });
});

app.put("/petowner/reservation/cancelled/reservationId", (req, res) => {
  const reservation_id = req.params.reservationId;
  const modeOfPayment = req.body.mop;
  const claimBy = req.body.claimBy;
  var date = new Date();
  date.setHours(date.getHours() + 8);
  var isodate = date.toISOString();
  // console.log(isodate);
  const sqlQuery =
    "UPDATE reservation SET reservation_status = ? , date_accomplished = ?, mop = ?, claimBy = ? WHERE reserve_id = ?";
  db.query(
    sqlQuery,
    ["Done", isodate, reservation_id, modeOfPayment, claimBy],
    (err, result) => {
      if (err == null) {
        res.send("Success");
      } else {
        console.log(err);
      }
    }
  );
});

app.get("/staff/order/:orderId", (req, res) => {
  const order_Id = req.params.orderId;
  const sqlQuery =
    "SELECT * FROM reservation_products JOIN products ON reservation_products.product_id = products.product_id WHERE order_id = ? ";
  db.query(sqlQuery, order_Id, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

app.get("/staff/order/total/:orderId", (req, res) => {
  const order_Id = req.params.orderId;
  const sqlQuery =
    "SELECT SUM(products.price * reservation_products.res_quantity) AS totalprice FROM reservation_products JOIN products ON reservation_products.product_id = products.product_id WHERE order_id = ?";
  db.query(sqlQuery, order_Id, (err, result) => {
    // console.log(result);
    res.send(JSON.parse(JSON.stringify(result)));
  });
});

app.put("/staff/expiration/reservation/:orderid", (req, res) => {
  const orderid = req.params.orderid;
  var date = new Date();
  date.setHours(date.getHours() + 8);
  var isodate = date.toISOString();
  // console.log(vetid);
  const sqlQuery =
    "UPDATE reservation SET reservation_status = 'Expired',date_accomplished = ? WHERE order_id = ? ";
  db.query(sqlQuery, isodate, orderid, (err, result) => {
    // console.log(result);
    res.send("Sucessfully updated");
  });
});

app.put("/staff/reservation/claim/:reservedId", (req, res) => {
  const reserved_Id = req.params.reservedId;
  const mop = req.body.mop;
  const claim_By = req.body.claimBy;
  const sqlQuery =
    "UPDATE reservation SET reservation_status = 'Purchased',mop = ?, claimBy= ? WHERE reserve_id = ? ";
  db.query(sqlQuery, [mop, claim_By, reserved_Id], (err, result) => {
    // console.log(result);
    res.send("Sucessfully updated");
  });
});

//add presciption and findings
app.put("/doc/consultation/:consultationId", (req, res) => {
  const docId = req.body.vet_doc_id;
  const consult_id = req.body.consultationId;
  const prescrip = req.body.prescrip;
  const findings = req.body.findings;

  const sqlQuery =
    "UPDATE consultation SET vet_doc_id= ?, prescription = ?, findings = ? WHERE consultation_id = ? ";
  db.query(sqlQuery, [docId, prescrip, findings, consult_id], (err, result) => {
    if (err === null) {
      res.send({ message: "Success" });
    } else {
      console.log(err);
    }
  });
});

//update consultation status
app.put("/doc/consultation/status/:appointmentId", (req, res) => {
  const appointmentId = req.params.appointmentId;
  // console.log(vetid);
  const sqlQuery =
    "UPDATE appointment SET appointment_status = 'Done' WHERE appointment_id = ? ";
  db.query(sqlQuery, appointmentId, (err, result) => {
    // console.log(result);
    res.send("Sucessfully updated");
  });
});

//add presciption and findings
app.put("/doc/examination/:medicalId", (req, res) => {
  const docId = req.body.vet_doc_id;
  const medicalHistoryId = req.body.medicalId;
  const prescrip = req.body.prescrip;
  const findings = req.body.findings;

  const sqlQuery =
    "UPDATE medical_history SET vet_doc_id= ?, prescription = ?, findings = ? WHERE medical_history_id = ?";
  db.query(
    sqlQuery,
    [docId, prescrip, findings, medicalHistoryId],
    (err, result) => {
      if (err === null) {
        res.send({ message: "Success" });
      } else {
        console.log(err);
      }
    }
  );
});

app.put("/doc/vaccination/:immuneId", (req, res) => {
  const immunizationId = req.body.immuneId;
  const weight = req.body.weight;
  const vaccine_name = req.body.vaccineName;
  const against = req.body.againsts;
  const manufacturer = req.body.manufacturer;
  const vaccineNumber = req.body.vaccineNumber;
  const prescrip = req.body.prescription;

  const sqlQuery =
    "UPDATE immunization_history SET pet_weight = ?, vaccine_name = ?, againts = ?, vaccine_number = ?, manufacturer = ?, prescription = ? WHERE immunization_id = ?";
  db.query(
    sqlQuery,
    [
      weight,
      vaccine_name,
      against,
      vaccineNumber,
      manufacturer,
      prescrip,
      immunizationId,
    ],
    (err, result) => {
      if (err === null) {
        res.send({ message: "Success" });
      } else {
        console.log(err);
      }
    }
  );
});

//vet admin notif api's
//number of new notif
app.get("/vetadmin/notification/length/:vetid", (req, res) => {
  // console.log(vetAdminId);
  const vetid = req.params.vetid;
  const sqlQuery =
    "SELECT * FROM notifications JOIN appointment ON notifications.appointment_id = appointment.appointment_id WHERE appointment.vetid = ? AND notifications.status  IN ('Pending','Cancelled') AND notifications.isViewed = 0";

  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result.length);
    if (err == null) {
      res.send({ view: result.length });
    } else {
      console.log(err);
    }
  });
});

//notif details
app.get("/vetadmin/notification/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  // console.log(pet_owner_id);
  const sqlQuery =
    "SELECT pet_owners.profilePicture, pet_owners.name, services.service_name, notifications.status, notifications.date_time_created FROM pet_owners JOIN appointment ON pet_owners.pet_owner_id = appointment.pet_owner_id JOIN notifications ON notifications.appointment_id = appointment.appointment_id JOIN services  ON services.service_id = notifications.service_id JOIN vet_clinic ON vet_clinic.vetid = services.vetid WHERE vet_clinic.vetid = ? && notifications.status IN ('Pending', 'Cancelled')  ORDER BY notifications.date_time_created DESC ";
  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result);
    res.send(result);
  });
});

//update the value of isview
app.put("/vetadmin/notification/viewed/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  const sqlQuery =
    "UPDATE pet_owners JOIN appointment ON pet_owners.pet_owner_id = appointment.pet_owner_id JOIN notifications ON notifications.appointment_id = appointment.appointment_id JOIN services ON services.service_id = notifications.service_id JOIN vet_clinic ON vet_clinic.vetid = services.vetid SET notifications.isViewed = 1 WHERE vet_clinic.vetid = ? && notifications.status IN ('Pending','Cancelled')";
  db.query(sqlQuery, vetid, (err, result) => {
    if (err === null) {
      res.send({ message: "Correct" });
    } else {
      console.log(err);
    }
  });
});

//number of new notif messages
app.get("/vetadmin/notification/messages/length/:vetid", (req, res) => {
  // console.log(vetAdminId);
  const vetid = req.params.vetid;
  const sqlQuery = "SELECT * FROM messages where vetid = ? AND isView = 0 ";

  db.query(sqlQuery, vetid, (err, result) => {
    // console.log(result.length);
    if (err == null) {
      res.send({ view: result.length });
    } else {
      console.log(err);
    }
  });
});

//update the value of isview on messages
app.put("/vetadmin/notification/messages/viewed/:vetid", (req, res) => {
  const vetid = req.params.vetid;
  const sqlQuery = "UPDATE messages SET isView = 1 where vetid = ?";
  db.query(sqlQuery, vetid, (err, result) => {
    if (err === null) {
      res.send({ message: "Correct" });
    } else {
      console.log(err);
    }
  });
});

//Record
//Health record
app.get("/pet/medical/history/record/:vetid/:id", (req, res) => {
  // console.log(vetAdminId);
  const vetid = req.params.vetid;
  const id = req.params.id;
  // console.log(id);
  const sqlQuery =
    "SELECT * FROM pet_owners JOIN pets ON pet_owners.pet_owner_id = pets.pet_owner_id JOIN appointment ON appointment.pet_id = pets.pet_id JOIN medical_history ON medical_history.appointment_id = appointment.appointment_id JOIN services ON services.service_id = medical_history.service_id WHERE appointment.vetid = ? AND appointment.pet_id = ? AND appointment.appointment_status = 'Done'";

  db.query(sqlQuery, [vetid, id], (err, result) => {
    // var resultData = JSON.parse(JSON.stringify(result));
    res.send(result);
    // console.log(result);
  });
});

//vaccine record
app.get("/pet/vaccine/record/:vetid/:id", (req, res) => {
  // console.log(vetAdminId);
  const vetid = req.params.vetid;
  const id = req.params.id;
  console.log("vaccineee" + vetid + " " + id);
  const sqlQuery =
    "SELECT * FROM pet_owners JOIN pets ON pet_owners.pet_owner_id = pets.pet_owner_id JOIN immunization_history ON immunization_history.pet_id = pets.pet_id JOIN appointment ON appointment.appointment_id = immunization_history.appointment_id JOIN services ON services.service_id = appointment.service_id WHERE appointment.vetid = ? AND appointment.pet_id = ? AND appointment.appointment_status = 'Done'";

  db.query(sqlQuery, [vetid, id], (err, result) => {
    // var resultData = JSON.parse(JSON.stringify(result));
    res.send(result);
    console.log(result);
  });
});

///consultation record
app.get("/pet/consultation/record/:vetid/:id", (req, res) => {
  // console.log(vetAdminId);
  const vetid = req.params.vetid;
  const id = req.params.id;
  // console.log(id);
  const sqlQuery =
    "SELECT * FROM pet_owners JOIN pets ON pet_owners.pet_owner_id = pets.pet_owner_id JOIN consultation ON consultation.pet_id = pets.pet_id JOIN appointment ON appointment.appointment_id = consultation.appointment_id JOIN services ON services.service_id = appointment.service_id WHERE appointment.vetid = ? AND appointment.pet_id = ? AND appointment.appointment_status = 'Done'";

  db.query(sqlQuery, [vetid, id], (err, result) => {
    // var resultData = JSON.parse(JSON.stringify(result));
    res.send(result);
    // console.log(result);
  });
});

app.get("/pet/grooming/record/:vetid/:id", (req, res) => {
  // console.log(vetAdminId);
  const vetid = req.params.vetid;
  const id = req.params.id;
  // console.log(id);
  const sqlQuery =
    "SELECT * FROM pet_owners JOIN pets ON pet_owners.pet_owner_id = pets.pet_owner_id JOIN appointment ON appointment.pet_id = pets.pet_id JOIN services ON services.service_id = appointment.service_id WHERE appointment.vetid = ? AND appointment.pet_id = ? AND appointment.appointment_status = 'Done' AND services.category = 'Pet Grooming'";

  db.query(sqlQuery, [vetid, id], (err, result) => {
    // var resultData = JSON.parse(JSON.stringify(result));
    res.send(result);
    // console.log(result);
  });
});

app.put("/staff/reservation/expired/:reservedId", (req, res) => {
  const reserved_Id = req.params.reservedId;
  const sqlQuery =
    "UPDATE reservation SET reservation_status = 'Expired' WHERE reserve_id = ? ";
  db.query(sqlQuery, reserved_Id, (err, result) => {
    // console.log(result);
    res.send("Sucessfully updated");
  });
});

//------------------------------------------------------------------------------------------------------------------
const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
  console.log("Im here");
  console.log(`Running  Server ${PORT}`);
});
