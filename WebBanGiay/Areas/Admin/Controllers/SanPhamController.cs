using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanGiay.App_Start;
using WebBanGiay.Models;
using static System.Net.Mime.MediaTypeNames;
using static System.Net.WebRequestMethods;

namespace WebBanGiay.Areas.Admin.Controllers
{
    public class SanPhamController : Controller
    {
        string connectionstring = @"Data Source=mssql-178969-0.cloudclusters.net,10083;Initial Catalog=WebBanGiay;User ID=tatbinh;Password=Ab123456";
        // GET: Admin/SanPham
        [@Authorize(role ="0,1")]
        public ActionResult DanhSach(string filter, int? idCategory, int? idBrand)
        {
            WebBanGiayEntities db = new WebBanGiayEntities();
            List<spDanhSachSanPham_Result> dskh = db.spDanhSachSanPham(filter, idCategory, idBrand).ToList();

            // Lấy thông tin số lượng tổng hợp từ bảng Warehouses
            var warehouseQuantities = db.WareHouses
                .GroupBy(w => w.Product_Id)
                .Select(g => new
                {
                    Product_Id = g.Key,
                    TotalQuantity = g.Sum(w => w.Quantity)
                }).ToDictionary(x => x.Product_Id, x => x.TotalQuantity);

            // Thêm thông tin số lượng tổng hợp vào danh sách sản phẩm
            foreach (var item in dskh)
            {
                if (warehouseQuantities.TryGetValue(item.Product_Id, out int totalQuantity))
                {
                    item.Product_Quantity = totalQuantity;
                }
            }

            ViewBag.filter = filter;
            ViewBag.idCategory = idCategory;
            ViewBag.idBrand = idBrand;
            return View(dskh);
        }



        [@Authorize(role ="0")]
        public ActionResult ThemMoi()
        {

            return View();
        }

        [HttpPost]
        public ActionResult ThemMoi(Product model, HttpPostedFileBase Product_Image)
        {
            
            WebBanGiayEntities db = new WebBanGiayEntities();
            db.Products.Add(model);
            db.SaveChanges();

            if (Product_Image != null && Product_Image.ContentLength > 0)
            {
                int id = int.Parse(db.Products.ToList().Last().Product_Id.ToString());

                string _FileName = "";
                int index = Product_Image.FileName.IndexOf('.');
                _FileName = "SP" + id.ToString() + "." + Product_Image.FileName.Substring(index + 1);
                string _path = Path.Combine(Server.MapPath("~/Areas/Admin/Data"), _FileName);
                Product_Image.SaveAs(_path);

                Product usp = db.Products.FirstOrDefault(m => m.Product_Id == id);
                usp.Product_Image = _FileName;
                db.SaveChanges();
            }
            using (SqlConnection sqlCon = new SqlConnection(connectionstring))
            {
                sqlCon.Open();

                // Thêm các size cho sản phẩm vào bảng KhoHang
                for (int size = 35; size <= 44; size++)
                {
                    string queryKhoHang = "INSERT INTO WareHouse (Product_Id, Size, Quantity) VALUES (@Product_Id, @Size, 30)";
                    using (SqlCommand cmdKhoHang = new SqlCommand(queryKhoHang, sqlCon))
                    {
                        cmdKhoHang.Parameters.AddWithValue("@Product_Id", model.Product_Id);
                        cmdKhoHang.Parameters.AddWithValue("@Size", size);
                        cmdKhoHang.ExecuteNonQuery();
                    }
                }
            }
            return RedirectToAction("DanhSach");
        }
        [@Authorize(role ="0")]
        public ActionResult Edit(int id)
        {
            WebBanGiayEntities db = new WebBanGiayEntities();
            Product model = db.Products.FirstOrDefault(m => m.Product_Id == id);
            return View(model);
        }

        [HttpPost]
        public ActionResult Edit(Product model, HttpPostedFileBase Product_Image)
        {
            WebBanGiayEntities db = new WebBanGiayEntities();
            Product model1 = db.Products.FirstOrDefault(m => m.Product_Id == model.Product_Id);
            model1.Product_Name = model.Product_Name;
            model1.Product_Price = model.Product_Price;
            model1.Product_Description = model.Product_Description;
            model1.Category_Id = model.Category_Id;
            model1.Brand_Id = model.Brand_Id;

            if (Product_Image != null && Product_Image.ContentLength > 0)
            {
                int id = model.Product_Id;

                string _FileName = "";
                int index = Product_Image.FileName.IndexOf('.');
                _FileName = "SP" + id.ToString() + "." + Product_Image.FileName.Substring(index + 1);
                string _path = Path.Combine(Server.MapPath("~/Areas/Admin/Data"), _FileName);
                Product_Image.SaveAs(_path);
                model1.Product_Image = _FileName;
                db.SaveChanges();
            }
            db.SaveChanges();
            return RedirectToAction("DanhSach");
        }
        [@Authorize(role ="0")]
        public ActionResult Delete(int id)
        {
            using (SqlConnection sqlCon = new SqlConnection(connectionstring))
            {
                sqlCon.Open();
                string query = "delete from WareHouse where Product_Id = @product_id";
                SqlCommand sqlcmd = new SqlCommand(query, sqlCon);
                sqlcmd.Parameters.AddWithValue("@product_id", id);
                sqlcmd.ExecuteNonQuery();
            }
            WebBanGiayEntities db = new WebBanGiayEntities();
            var model = db.Products.Find(id);
            db.Products.Remove(model);
            db.SaveChanges();
            return RedirectToAction("DanhSach");

        }
    }
}