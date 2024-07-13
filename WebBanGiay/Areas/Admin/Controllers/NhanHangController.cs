using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanGiay.App_Start;
using WebBanGiay.Models;

namespace WebBanGiay.Areas.Admin.Controllers
{
    public class NhanHangController : Controller
    {
        // GET: Admin/NhanHang
        [@Authorize(role ="0,1")]
        public ActionResult DanhSach()
        {
            WebBanGiayEntities db = new WebBanGiayEntities();

            return View(db.Brands.ToList());
        }
        [@Authorize(role ="0")]
        public ActionResult ThemMoi()

        {

            return View();
        }
        [HttpPost]
        public ActionResult ThemMoi(Brand model)
        {
            if (string.IsNullOrEmpty(model.Brand_Name) == true)
            {
                ModelState.AddModelError("", "Không được để trống");
                return View(model);
            }
            WebBanGiayEntities db = new WebBanGiayEntities();
            db.Brands.Add(model);
            db.SaveChanges();
            return RedirectToAction("DanhSach");
        }
        [@Authorize(role ="0")]
        public ActionResult Edit(int id)

        {
            WebBanGiayEntities db = new WebBanGiayEntities();
            var model = db.Brands.Find(id);

            return View(model);
        }
        [HttpPost]
        public ActionResult Edit(Brand model)
        {
            if (string.IsNullOrEmpty(model.Brand_Name) == true)
            {
                ModelState.AddModelError("", "Không được để trống");
                return View(model);
            }

            WebBanGiayEntities db = new WebBanGiayEntities();
            var updateModel = db.Brands.Find(model.Brand_Id);
            updateModel.Brand_Name = model.Brand_Name;
            db.SaveChanges();
            return RedirectToAction("DanhSach");
        }
        [@Authorize(role ="0")]
        public ActionResult Delete(int id)
        {
            WebBanGiayEntities db = new WebBanGiayEntities();
            var model = db.Brands.Find(id);
            db.Brands.Remove(model);
            db.SaveChanges();
            return RedirectToAction("DanhSach");

        }
    }
}