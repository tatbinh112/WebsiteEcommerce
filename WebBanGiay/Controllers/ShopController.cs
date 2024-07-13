using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanGiay.Models;
using PagedList;
using System.Drawing.Printing;


namespace WebBanGiay.Controllers
{
    public class ShopController : Controller
    {

        private WebBanGiayEntities db = new WebBanGiayEntities();

        // GET: Shop
        public ActionResult Index(string sortOrder, int[] CantegoryFilter ,string CurrentCantegoryFilter, int? BrandFilter, int? page)
        {
            



            ViewBag.CurrentSort = sortOrder;
            ViewBag.BrandFilter = BrandFilter;

            ViewBag.CurrentCantegoryFilter = CurrentCantegoryFilter;
            if (CurrentCantegoryFilter != null ) 
            {
                CantegoryFilter= CurrentCantegoryFilter.Split(',').Select(int.Parse).ToArray();
            }
            ViewBag.CantegoryFilter = CantegoryFilter;
            




            var Products = from s in db.Products select s;


            if (page == null) 
            {
                page = 1;
             }

            if (CantegoryFilter != null && CantegoryFilter.Any())
            {
            

                Products = Products
                               .Where(p => CantegoryFilter.Contains(p.Category_Id.Value));
                


            }


            if (BrandFilter != null)
            {
                 Products = Products
             .Where(p => p.Brand_Id == BrandFilter);


            }
            


            switch (sortOrder)
            {
                case "name_desc":
                    Products = Products.OrderByDescending(p => p.Product_Name);
                    break;
                case "name":
                    Products = Products.OrderBy(p => p.Product_Name);
                    break;
                case "price_desc":
                    Products = Products.OrderByDescending(p => p.Product_Price);
                    break;
                case "price":
                    Products = Products.OrderBy(p => p.Product_Price);
                    break;
                default:
                    Products = Products.OrderBy(p => p.Product_Name);
                    break;
            }

            
             int pagesize = 6;

            ViewBag.pagesize = pagesize;

            return View(Products.ToPagedList((int)page,(int)pagesize));
        }
        public ActionResult ChiTiet(int id)
        {
            var model = db.Products.Find(id);
            return View(model);
        }



    }
}