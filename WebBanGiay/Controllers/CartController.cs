using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebBanGiay.Models;

namespace WebBanGiay.Controllers
{
    public class CartController : Controller
    {
        private WebBanGiayEntities db = new WebBanGiayEntities();

        
        // GET: Cart
        public ActionResult Index()
        {

            if (Session["Customer"] == null)
            {
                return View((List<Cart>)Session["Cart"]);
            }
            else
            {
                return View(db.Carts.ToList());

            }

        }
        [HttpPost]
        public ActionResult AddToCart(Cart model)
        {
            
            var Customer = Session["Customer"] as User;
            // chưa đăng nhập
            if (model.User_Id != 0) 
            {
                db.Carts.Add(model);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            else 
            {
                var Carts = new List<Cart>();
                if (Session["Cart"] == null)
                {
                    Carts.Add(model);
                    Session["Cart"] = Carts;
                    return RedirectToAction("Index");

                }
                else
                {
                    Carts = Session["Cart"] as List<Cart>;

                    //kiểm tra sản phẩm có tồn tại không
                    var cartItem = Carts.FirstOrDefault(c => c.Product_Id == model.Product_Id && c.Size == model.Size);
                    if (cartItem !=null) 
                    {
                        cartItem.Quantity += model.Quantity;
                    }
                    else
                    {
                        Carts.Add(model);
                    }
                    Session["Cart"] = Carts;

                    return RedirectToAction("Index");

                }

            }
        }

        


    }
}