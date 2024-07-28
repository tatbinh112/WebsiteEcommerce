using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using WebBanGiay.Models;

namespace WebBanGiay.Controllers
{
    public class AccountController : Controller
    {
        // GET: Account
        private WebBanGiayEntities db = new WebBanGiayEntities();
        public ActionResult Login()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Login(string user, string password)
        {
            var Customer = db.Users.SingleOrDefault(m => (m.User_Name == user) && m.Pass_Word == password);
            if (Customer != null)
            {
                Session["Customer"] = Customer;

                return Redirect("/Home/Index");
            }
            else
            {
                TempData["error"] = "Username or Password incorrect";
                return View();

            }
        }
        public ActionResult Create()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Create(User model)
        {
            bool check = true;
            int username = db.Users.Count(u => u.User_Name == model.User_Name);
            if (username > 0)
            {
                check = false;
                TempData["user"] = "Username already exists";
            }
            int sdt = db.Users.Count(u => u.Phone_Number == model.Phone_Number);
            if (sdt > 0)
            {
                check = false;
                TempData["phone"] = "Phone number already exists";
            }
            int mail = db.Users.Count(u => u.Email == model.Email);
            if (mail > 0)
            {
                check = false;
                TempData["email"] = "Email already exists";
            }

            if (check)
            {
                db.Users.Add(model);
            }

            else { return View(model); }
            return View();
        }

        [HttpPost]
        public ActionResult Update(User model)
        {
            var user = db.Users.SingleOrDefault(m => m.User_Id == model.User_Id);
            user.Name = model.Name;
            user.Email = model.Email;
            user.Phone_Number = model.Phone_Number;
            db.SaveChanges();
            Session["Customer"] = user;

            return RedirectToAction("ProfileCustomer");

        }
        public ActionResult Logout()
        {
            Session.Remove("Customer");
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Home");
        }
        public ActionResult ProfileCustomer()
        {
            var Customer = Session["Customer"] as User;
            if (Customer != null)
            {
                var orders = db.Orders.Where(o => o.User_Id == Customer.User_Id).ToList();
                int? totalSpent = orders.Sum(o => o.Total_Amount);
                ViewBag.TotalSpent = totalSpent;
            }
            else
            {
                ViewBag.TotalSpent = 0;
            }
            return View(Customer);
        }

    }
}