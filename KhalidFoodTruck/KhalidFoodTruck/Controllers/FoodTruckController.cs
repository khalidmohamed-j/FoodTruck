using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace KhalidFoodTruck.Controllers
{
    public class FoodTruckController : ApiController
    {
        FoodTruckModelContainer foodTruck = new FoodTruckModelContainer();

        // https://localhost:44335/api/FoodTruck/GetAllNotes
        public IEnumerable<object> GetAllFoodTrucks()
        {

            var foodTruckCollection = from fdTruck in foodTruck.FoodTrucks
                                 select new { fdTruck.FoodTruckID, fdTruck.FoodTruckName, fdTruck.FoodTruckPlateNumber, fdTruck.FoodTypeID };
            var FoodTruckData = foodTruckCollection;

            return FoodTruckData.ToList();
        }

        public IHttpActionResult GetFoodTruck(int id)
        {
            // var product = WebApiConfig.myList.FirstOrDefault((p) => p.Id == id);


            try
            {
                var FindOne = (from fdTruck in foodTruck.FoodTrucks
                               where fdTruck.FoodTruckID == id
                               select new { fdTruck.FoodTruckID, fdTruck.FoodTruckName, fdTruck.FoodTruckPlateNumber }).First();
                return Ok(FindOne);
            }
            catch (Exception)
            {

                return NotFound();
            }

        }

        //public IHttpActionResult GetLocation(int id)
        //{
        //    // var product = WebApiConfig.myList.FirstOrDefault((p) => p.Id == id);


        //    try
        //    {
        //        var FindOne = (from fdTruck in foodTruck.FoodTruckLocations
        //                       where fdTruck.FoodTruckLocationID == id
        //                       select new { fdTruck.FoodTruckID, fdTruck.FoodTruckLocationDay }).First();
        //        return Ok(FindOne);
        //    }
        //    catch (Exception)
        //    {

        //        return NotFound();
        //    }

        //}


        public class FoodTruckPart
        {
            public int FoodTruckID { get; set; }
            public int FoodTypeID { get; set; }
            public string FoodTruckPlateNumber { get; set; }
            public string FoodTruckName { get; set; }
        }


        [HttpPost]
        public FoodTruckPart Save(FoodTruckPart tempFoodTruck)
        {
            ////WebApiConfig.myList.Add(newNote);
            FoodTruck newfoodTruck = new FoodTruck();
            //newNote.NoteID = tempNote.NoteID;  SQL will make up the ID
            newfoodTruck.FoodTruckID = tempFoodTruck.FoodTruckID;
            newfoodTruck.FoodTruckName = tempFoodTruck.FoodTruckName;
            newfoodTruck.FoodTruckPlateNumber = tempFoodTruck.FoodTruckPlateNumber;
            newfoodTruck.FoodTypeID = tempFoodTruck.FoodTypeID;
            var GetOneFoodTypeObject = (from oneFoodType in foodTruck.FoodTypes
                                        where oneFoodType.FoodTypeID == newfoodTruck.FoodTypeID
                                        select oneFoodType).First();

            newfoodTruck.FoodType = GetOneFoodTypeObject;
            foodTruck.FoodTrucks.Add(newfoodTruck);
            foodTruck.SaveChanges();

            return tempFoodTruck;
        }


        [HttpDelete]
        public HttpResponseMessage DELETE(int id)
        {
            try
            {
                var foodTruckToDelete = (from fdTruck in foodTruck.FoodTrucks
                                         where fdTruck.FoodTruckID == id
                                         select fdTruck).First();

                FoodTruck thisOne = foodTruckToDelete;
                foodTruck.FoodTrucks.Remove(thisOne);
                foodTruck.SaveChanges();
                HttpResponseMessage goodResponse = new HttpResponseMessage();
                goodResponse.StatusCode = HttpStatusCode.OK;
                return goodResponse;
            }
            catch (Exception)
            {
                HttpResponseMessage badResponse = new HttpResponseMessage();
                badResponse.StatusCode = HttpStatusCode.BadRequest;
                return badResponse;
            }

        }

        [HttpPut]
        public IHttpActionResult PutModify(int id, [FromBody] FoodTruckPart tempfoodTruck)
        {
            try
            {
                var FoodTruckToChange = (from fdTruck in foodTruck.FoodTrucks
                                    where fdTruck.FoodTruckID == id
                                    select fdTruck).First();

                FoodTruck thefdTruck = FoodTruckToChange;


                thefdTruck.FoodTruckID = tempfoodTruck.FoodTruckID;
                thefdTruck.FoodTruckName = tempfoodTruck.FoodTruckName;
                thefdTruck.FoodTruckPlateNumber = tempfoodTruck.FoodTruckPlateNumber;
                thefdTruck.FoodTypeID = tempfoodTruck.FoodTypeID;

                var GetOneFoodTypeObject = (from oneFoodType in foodTruck.FoodTypes
                                            where oneFoodType.FoodTypeID == thefdTruck.FoodTypeID
                                            select oneFoodType).First();

                thefdTruck.FoodType = GetOneFoodTypeObject;

                foodTruck.SaveChanges();
                return Ok("success");
            }
            catch (Exception)
            {
                return NotFound();
            }

        }
    }
}
