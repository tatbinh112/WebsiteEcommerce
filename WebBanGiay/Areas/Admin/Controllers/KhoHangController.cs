using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Xml.Linq;
using WebBanGiay.Models;
using System.Drawing;
using WebBanGiay.App_Start;

namespace WebBanGiay.Areas.Admin.Controllers
{
    public class KhoHangController : Controller
    {
        [@Authorize(role ="0,1")]
        // GET: Admin/KhoHang
        public ActionResult DanhSach(int? id)
        {
            WebBanGiayEntities db = new WebBanGiayEntities();
            ViewBag.name = "DanhSach";
            ViewBag.ID = id;
            if (id == null)
            {
                id = 0;
            }
            else
            {
                ViewBag.name = db.Products.Find(id).Product_Name.ToString();
            }


            List<SP_XemKhoHangTuSanPham_Result> DanhSachKhoHang = db.SP_XemKhoHangTuSanPham(id).ToList();
            return View(DanhSachKhoHang);
            

            
        }
        [@Authorize(role ="0,1")]
        public ActionResult ThemMoi(int? id)
        {
            
            
            WebBanGiayEntities db = new WebBanGiayEntities();
            ViewBag.name = "";
            ViewBag.ID = id;

            if (id == null)
            {
                id = 0;
            }
            else
            {
                ViewBag.name = db.Products.Find(id).Product_Name.ToString() ;
                ViewBag.nameTitle = ViewBag.name + " /";
            }

            return View();
        }
        [HttpPost]
        public ActionResult ThemMoi(WareHouse model)
        {
            if (ModelState.IsValid)
            {
                using (WebBanGiayEntities db = new WebBanGiayEntities())
                {
                    // Kiểm tra xem sản phẩm có sẵn trong kho hàng chưa
                    var productInWarehouse = db.WareHouses
                        .SingleOrDefault(k => k.Product_Id == model.Product_Id && k.Size == model.Size);

                    if (productInWarehouse != null)
                    {
                        // Nếu sản phẩm đã có trong kho hàng, cập nhật số lượng
                        productInWarehouse.Quantity += model.Quantity;
                    }
                    else
                    {
                        // Nếu sản phẩm chưa có trong kho hàng, thêm mới vào kho hàng
                        db.WareHouses.Add(new WareHouse
                        {
                            Product_Id = model.Product_Id,
                            Size = model.Size,
                            Quantity = model.Quantity
                        });
                    }

                    // Lưu các thay đổi vào cơ sở dữ liệu
                    db.SaveChanges();

                    return RedirectToAction("DanhSach"); // Điều hướng đến trang khác sau khi thêm thành công
                }
            }

            return View(model);
        }


        [@Authorize(role ="0")]
        public ActionResult Edit(int id)
        {
            ViewBag.name = "";
            WebBanGiayEntities db = new WebBanGiayEntities();
            WareHouse model = db.WareHouses.FirstOrDefault(m => m.ProWH_Id == id);
            ViewBag.name = db.Products.Find(model.Product_Id).Product_Name.ToString();

            return View(model);
        }

        [HttpPost]
        public ActionResult Edit(WareHouse model)
        {
            
            WebBanGiayEntities db = new WebBanGiayEntities();
            WareHouse model1 = db.WareHouses.FirstOrDefault(m => m.ProWH_Id == model.ProWH_Id);
            model1.Product_Id = model.Product_Id;
            model1.Size = model.Size;
            model1.Quantity = model.Quantity;
            

            
            db.SaveChanges();
            return RedirectToAction("DanhSach");
        }
        [@Authorize(role ="0")]
        public ActionResult Delete(int id)
        {
            WebBanGiayEntities db = new WebBanGiayEntities();
            var model = db.WareHouses.Find(id);
            db.WareHouses.Remove(model);
            db.SaveChanges();
            return RedirectToAction("DanhSach");

        }
    }
}