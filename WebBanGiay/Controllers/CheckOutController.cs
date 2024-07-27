﻿using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.EnterpriseServices.CompensatingResourceManager;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanGiay.Models;

namespace WebBanGiay.Controllers
{
    public class CheckOutController : Controller
    {
        private WebBanGiayEntities db = new WebBanGiayEntities();

        private vietnamese_administrative_unitsEntities vn = new vietnamese_administrative_unitsEntities();

        // GET: CheckOut
        public ActionResult Index()
        {
            var Customer = Session["Customer"] as User;
            if (Customer == null)
            {
                var cart = Session["Cart"] as List<Cart>;
                // Kiểm tra giỏ hàng có sản phẩm không
                if (cart == null || !cart.Any())
                {

                    return RedirectToAction("CheckOut", "Cart");
                }
                else
                {
                    return View((List<Cart>)Session["Cart"]);
                }
            }
            else
            {
                var cart = db.Carts.Where(c => c.User_Id == Customer.User_Id).ToList();
                // Kiểm tra giỏ hàng có sản phẩm không
                if (cart == null || !cart.Any())
                {

                    return RedirectToAction("CheckOut", "Cart");
                }
                else
                {
                    return View(cart);
                }
            }
            return View();

        }
        public JsonResult GetDistricts(string province_code)
        {
            vn.Configuration.ProxyCreationEnabled = false;
            var districts = vn.districts.Where(d => d.province_code == province_code).ToList();
            return Json(districts, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetWards(string district_code)
        {
            vn.Configuration.ProxyCreationEnabled = false;
            var wards = vn.wards.Where(w => w.district_code == district_code).ToList();
            return Json(wards, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult Payment(Order model, string Total_Amount)
        {
            ObjectParameter maxidParam = new ObjectParameter("maxid", typeof(int));
            var Customer = Session["Customer"] as User;
            model.User_Id = Customer.User_Id;
            model.Date = DateTime.Now;

            // Chuyển đổi Total_Amount từ string sang decimal
            if (decimal.TryParse(Total_Amount, out decimal totalAmount))
            {
                model.Total_Amount = (int?)totalAmount;
            }
            else
            {
                // Xử lý lỗi nếu việc chuyển đổi không thành công
                ModelState.AddModelError("", "Total Amount is not valid.");
                return View(model);
            }

            db.spAddOrder(model.Date, model.User_Id, model.Total_Amount, model.Discount_Id, model.Ship_Address, model.Ship_Email, model.Ship_PhoneNumber, model.Ship_Note, model.Ship_Name, maxidParam);
            int maxID = (int)maxidParam.Value;

            List<Cart> cart;

            if (Customer != null)
            {
                cart = db.Carts.Where(c => c.User_Id == Customer.User_Id).ToList();
                foreach (var item in cart)
                {
                    db.spAddOrderDetail(maxID, item.Product_Id, item.Quantity, item.Size);
                    UpdateWarehouse(item.Product_Id ?? 0, item.Size ?? 0, item.Quantity ?? 0);
                }
            }
            else
            {
                var cartItem = Session["Cart"] as List<Cart>;
                cart = cartItem.Where(c => c.User_Id == Customer.User_Id).ToList();
                foreach (var item in cart)
                {
                    db.spAddOrderDetail(maxID, item.Product_Id, item.Quantity, item.Size);
                    UpdateWarehouse(item.Product_Id ?? 0, item.Size ?? 0, item.Quantity ?? 0);
                }
            }

            db.SaveChanges();

            return RedirectToAction("index", "Shop");
        }


        private void UpdateWarehouse(int productId, int size, int quantity)
        {
            var warehouseItem = db.WareHouses.SingleOrDefault(w => w.Product_Id == productId && w.Size == size);
            if (warehouseItem != null)
            {
                warehouseItem.Quantity -= quantity;
                db.Entry(warehouseItem).State = System.Data.Entity.EntityState.Modified;
                db.SaveChanges();
            }
        }

    }


}