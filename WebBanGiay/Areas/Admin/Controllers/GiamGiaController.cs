using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanGiay.App_Start;
using WebBanGiay.Models;

namespace WebBanGiay.Areas.Admin.Controllers
{
    public class GiamGiaController : Controller
    {
        // GET: Admin/GiamGia
        [@Authorize(role ="0,1")]
        public ActionResult DanhSach()

        {
            WebBanGiayEntities db = new WebBanGiayEntities();

            return View(db.Discounts.ToList());
        }
        [@Authorize(role ="0")]
        public ActionResult Create()

        {

            return View();
        }
        [HttpPost]
        public ActionResult Create(Discount model)
        {
            if (model.Type != true)
            {
                model.Type = false;
            }
            if (string.IsNullOrEmpty(model.Discount_Code) == true)
            {
                ModelState.AddModelError("", "Không được để trống");
                return View(model);
            }
            WebBanGiayEntities db = new WebBanGiayEntities();
            db.Discounts.Add(model);
            db.SaveChanges();
            return RedirectToAction("DanhSach");
        }
        [@Authorize(role ="0")]
        public ActionResult Edit(int id)

        {
            WebBanGiayEntities db = new WebBanGiayEntities();
            var model = db.Discounts.Find(id);

            return View(model);
        }
        [HttpPost]
        public ActionResult Edit(Discount model)
        {
            if (model.Type != true)
            {
                model.Type = false;
            }
            if (string.IsNullOrEmpty(model.Discount_Code) == true)
            {
                ModelState.AddModelError("", "Không được để trống");
                return View(model);
            }

            WebBanGiayEntities db = new WebBanGiayEntities();
            var updateModel = db.Discounts.Find(model.Discount_Id);
            updateModel.Discount_Code = model.Discount_Code;
            updateModel.Discount_Quantity = model.Discount_Quantity;
            updateModel.Discount_Percent = model.Discount_Percent;
            updateModel.Type = model.Type;
            db.SaveChanges();
            return RedirectToAction("DanhSach");
        }
        [@Authorize(role ="0")]
        public ActionResult Delete(int id)
        {
            WebBanGiayEntities db = new WebBanGiayEntities();
            var model = db.Discounts.Find(id);
            db.Discounts.Remove(model);
            db.SaveChanges();
            return RedirectToAction("DanhSach");

        }
    }
}