var express = require('express');
var bodyParser = require('body-parser');
var MongoClient = require('mongodb').MongoClient;
var ObjectID = require('mongodb').ObjectID;

var app = express();
app.use(bodyParser.urlencoded({extended: true}))

var db;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.get('/people', function (req, res) {
  db.collection('people').find().toArray(function (err, docs){
    if (err) {
      console.log(err);
      return res.sendStatus(404);
    }

    res.send(docs);
  })
})

app.get('/people/:login/:password', function (req, res) {
  db.collection('people').findOne({ login: req.params.login}, function (err, doc) {
    if (err) {
      console.log(err);
      return res.sendStatus(404);
    }
    if (doc != null) {
      db.collection('peoplePass').findOne({ login: doc.login}, function (err2, doc2) {
        if (err2) {
          console.log(err2);
          return res.sendStatus(404);
        }
        if (doc2 != null) {
          if (doc2.password == req.params.password)
          res.send(doc);
        } else {
          return res.sendStatus(404);
        }
      })
    } else {
      return res.sendStatus(404);
    }
  })
})

app.post('/people', function (req, res){
  db.collection('peoplePass').findOne({ login: req.body.login}, function (err, doc) {
    if (err) {
      console.log(err);
      return res.sendStatus(404);
    }

    if (doc != null) {
      console.log(doc)
      return res.sendStatus(404);
    } else {
      var personInfo = {
        login: req.body.login,
	password: "скрыто",
        name: req.body.name,
        age: (req.body.age != null) ? req.body.age : "null",
        gender: (req.body.gender != null) ? req.body.gender : "null",
        height: (req.body.height != null) ? req.body.height : "null",
        mass: (req.body.mass != null) ? req.body.mass : "null"
      };
      var infLogin = {
        login: req.body.login,
        password: req.body.password,
      };

      console.log(personInfo);
      console.log(infLogin);

      db.collection('peoplePass').insertOne(infLogin, function (err, result) {
        if (err) {
          console.log(err);
          return res.sendStatus(404);
        }
      })

      db.collection('people').insertOne(personInfo, function (err, result) {
        if (err) {
          console.log(err);
          return res.sendStatus(404);
        }
        res.send(personInfo);
      })
    }
  })
})

MongoClient.connect('mongodb://localhost:27017/myapi', function (err, database) {
  if (err) {
    return console.log(err);
  }
  db = database.db('test4Users');

  app.listen(3012, function () {
    console.log('Api app started');
  })

})
