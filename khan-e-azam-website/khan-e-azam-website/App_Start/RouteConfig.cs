using System;
using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;

namespace khan_e_azam_website
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            var settings = new FriendlyUrlSettings
            {
                AutoRedirectMode = RedirectMode.Permanent
            };

            routes.EnableFriendlyUrls(settings);

            // Redirect root URL to Home.aspx
            routes.MapPageRoute(
                "Home",
                "",
                "~/Home.aspx"
            );
        }
    }
}