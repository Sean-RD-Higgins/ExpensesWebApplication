using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Routing;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.FriendlyUrls.Resolvers;

namespace ExpensesWebApplication
{
    public partial class ViewSwitcher : System.Web.UI.UserControl
    {
        private const string DESKTOP = "Desktop";
        private const string MOBILE = "Mobile";

        protected string CurrentView { get; private set; }

        protected string AlternateView { get; private set; }

        protected string SwitchUrl { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            var isUsingMobileSwitcher = (ConfigurationManager.AppSettings["IsUsingMobileSwitcher"] ?? "false") == "true";

            // Determine current view
            var isMobile = WebFormsFriendlyUrlResolver.IsMobileView(new HttpContextWrapper(Context));
            CurrentView = isMobile ? MOBILE : DESKTOP;

            // Determine alternate view
            AlternateView = isMobile ? DESKTOP : MOBILE;

            if (!isUsingMobileSwitcher) {
                CurrentView = DESKTOP;
                AlternateView = DESKTOP;
            }

            // Create switch URL from the route, e.g. ~/__FriendlyUrls_SwitchView/Mobile?ReturnUrl=/Page
            var switchViewRouteName = "AspNet.FriendlyUrls.SwitchView";
            var switchViewRoute = RouteTable.Routes[switchViewRouteName];
            if (switchViewRoute == null)
            {
                // Friendly URLs is not enabled or the name of the switch view route is out of sync
                this.Visible = false;
                return;
            }
            var url = GetRouteUrl(switchViewRouteName, new { view = AlternateView, __FriendlyUrls_SwitchViews = true });
            url += "?ReturnUrl=" + HttpUtility.UrlEncode(Request.RawUrl);
            SwitchUrl = url;
        }
    }
}