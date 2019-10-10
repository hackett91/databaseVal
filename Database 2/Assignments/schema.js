{
    "_id" : ObjectId("5c121053751c8d0ef4e6c3f7"),
    "sport" : "Archery",
    "discipline" : "Archery",
    "men" : [
        {
            "name" : "PETIT, Charles Frédéric",
            "nationality" : "FRA",
            "gender" : "Men",
            "medal" : "Bronze",
            "edition" : "1900",
            "city" : "Paris",
            "event" : "au chapelet, 33m"
        },
    "women" : [
        {
            "name" : "POLLOCK, Jessie",
            "nationality" : "USA",
            "gender" : "Women",
            "medal" : "Bronze",
            "edition" : "1904",
            "city" : "St Louis",
            "event" : "double columbia round (50y - 40y - 30y)"
        }]
}

{
    "_id" : ObjectId("5c1068e6751c8d0b7f933a6a"),
    "City" : "Athens",
    "Edition" : NumberInt(1896),
    "Sport" : "Aquatics",
    "Discipline" : "Swimming",
    "Athlete" : "HAJOS, Alfred",
    "NOC" : "HUN",
    "Gender" : "Men",
    "Event" : "100m freestyle",
    "Event_gender" : "M",
    "Medal" : "Gold"
}
{
    "_id" : ObjectId("5c1068e6751c8d0b7f933a6b"),
    "City" : "Athens",
    "Edition" : NumberInt(1896),
    "Sport" : "Aquatics",
    "Discipline" : "Swimming",
    "Athlete" : "HERSCHMANN, Otto",
    "NOC" : "AUT",
    "Gender" : "Men",
    "Event" : "100m freestyle",
    "Event_gender" : "M",
    "Medal" : "Silver"
}


//return all in collection
db.getCollection("newSchema").find({})


//find all the women in swimming using selection and projection
db.getCollection("newSchema").find({discipline: "Swimming"},{"_id": 0, "men": 0})

//sort according to discipline
db.getCollection("newSchema").find().sort({"discipline": 1})

// aggregation
db.getCollection("newSchema").aggregate(
   [
      {
         $project: {
            discipline: 1,

            mensMedals: { $size: "$men" }
         }
      }
   ]
)


{
    "sport" : "Aquatics",
    "discipline" : "Swimming",
    "women" : [
        {
            "name" : "FLETCHER, Jennie",
            "nationality" : "GBR",
            "gender" : "Women",
            "medal" : "Bronze",
            "edition" : "1912",
            "city" : "Stockholm",
            "event" : "100m freestyle"
        }]
}

{
    "_id" : ObjectId("5c121053751c8d0ef4e6c3f7"), 
    "sport" : "Archery",
    "discipline" : "Archery",
    "men" : [
        {
            "name" : "PETIT, Charles Frédéric",
            "nationality" : "FRA",
            "gender" : "Men",
            "medal" : "Bronze",
            "edition" : "1900",
            "city" : "Paris",
            "event" : "au chapelet, 33m"
        }
      ]
  }

{
    "_id" : ObjectId("5c121053751c8d0ef4e6c3ee"),
    "discipline" : "Swimming",
    "mensMedals" : NumberInt(751)
}
