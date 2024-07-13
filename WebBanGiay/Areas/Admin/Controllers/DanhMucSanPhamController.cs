using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanGiay.App_Start;
using WebBanGiay.Models;

namespace WebBanGiay.Areas.Admin.Controllers
{
    public class DanhMucSanPhamController : Controller
    {
        // GET: Admin/DanhMucSanPham
        [@Authorize(role ="0,1")]

        public ActionResult DanhSach()

        {
            WebBanGiayEntities db = new WebBanGiayEntities();

            return View(db.Categories.ToList());
        }
        [@Authorize(role ="0")]

        public ActionResult Create()

        {

            return View();
        }
        [HttpPost]
        public ActionResult Create(Category model)
        {
            if (string.IsNullOrEmpty(model.Category_Name) == true)
            {
                ModelState.AddModelError("", "Không được để trống");
                return View(model);
            }
            WebBanGiayEntities db = new WebBanGiayEntities();
            db.Categories.Add(model);
            db.SaveChanges();
            return RedirectToAction("DanhSach");
        }
        [@Authorize(role ="0")]
        public ActionResult Edit(int id)

        {
            WebBanGiayEntities db = new WebBanGiayEntities();
            var model = db.Categories.Find(id);

            return View(model);
        }
        [HttpPost]
        public ActionResult Edit(Category model)
        {
            if (string.IsNullOrEmpty(model.Category_Name) == true)
            {
                ModelState.AddModelError("", "Không được để trống");
                return View(model);
            }

            WebBanGiayEntities db = new WebBanGiayEntities();
            var updateModel = db.Categories.Find(model.Category_Id);
            updateModel.Category_Name = model.Category_Name;
            db.SaveChanges();
            return RedirectToAction("DanhSach");
        }

        [@Authorize(role ="0")]
        public ActionResult Delete(int id)
        {
            WebBanGiayEntities db = new WebBanGiayEntities();
            var model = db.Categories.Find(id);
            db.Categories.Remove(model);
            db.SaveChanges();
            return RedirectToAction("DanhSach");

        }
    } 
}