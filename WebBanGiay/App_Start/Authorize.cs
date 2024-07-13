using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using WebBanGiay.Models;


namespace WebBanGiay.App_Start
{
    public class Authorize: AuthorizeAttribute
    {

        public string role { get; set; }
        public override void OnAuthorization(AuthorizationContext filterContext)
        {

            int[] idLoai= Array.ConvertAll(role.Split(','),int.Parse);
            //check session
            User userSession = (User)HttpContext.Current.Session["user"]; 
            if((userSession != null)  ) 
            {
                bool check = idLoai.Contains(Convert.ToInt32(userSession.Type));
                WebBanGiayEntities db = new WebBanGiayEntities();
                if (check)
                {
                    return;
                }
                else
                {
                    var returnUrl = filterContext.HttpContext.Request.RawUrl;
                    filterContext.Result = new RedirectToRouteResult(new
                        RouteValueDictionary(new
                        {
                            Controller = "AdminError",
                            Action = "KhongCoQuyen",
                            area = "Admin",
                            returnUrl = returnUrl.ToString()
                        })
                        );
                }

            }
            else 
            {
                var returnUrl= filterContext.HttpContext.Request.RawUrl;
                filterContext.Result = new RedirectToRouteResult(new
                    RouteValueDictionary(new
                    {
                        Controller = "AdminAccount",
                        Action = "Login", area= "Admin",
                        returnUrl=returnUrl.ToString()
                    })
                    );
            }
            
        }
    }
}