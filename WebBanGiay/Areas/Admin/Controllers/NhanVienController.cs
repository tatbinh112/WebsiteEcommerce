using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanGiay.App_Start;
using WebBanGiay.Models;

namespace WebBanGiay.Areas.Admin.Controllers
{
    public class NhanVienController : Controller
    {
        // GET: Admin/NhanVien
        [@Authorize(role ="0")]
        public ActionResult DanhSach()
        {
            WebBanGiayEntities db = new WebBanGiayEntities();

            var NV= db.Users.ToList();
            return View(NV);
        }
        [@Authorize(role ="0")]
        public ActionResult Create()

        {
            return View();
        }
        [HttpPost]
        public ActionResult Create(User model)
        {
            if (string.IsNullOrEmpty(model.User_Name) == true)
            {
                ModelState.AddModelError("", "Không được để trống");
                return View(model);
            }
            WebBanGiayEntities db = new WebBanGiayEntities();
            db.Users.Add(model);
            db.SaveChanges();
            return RedirectToAction("DanhSach");
        }
        [@Authorize(role ="0")]
        public ActionResult Delete(int id)
        {
            WebBanGiayEntities db = new WebBanGiayEntities();
            var model = db.Users.Find(id);
            db.Users.Remove(model);
            db.SaveChanges();
            return RedirectToAction("DanhSach");

        }
    }
}