﻿//------------------------------------------------------------------------------
// <auto-generated>
//     此代码由工具生成。
//     运行时版本:4.0.30319.42000
//
//     对此文件的更改可能会导致不正确的行为，并且如果
//     重新生成代码，这些更改将会丢失。
// </auto-generated>
//------------------------------------------------------------------------------

namespace ProxyClient
{
    [System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "4.0.30319.1")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Web.Services.WebServiceBindingAttribute(Name = "GetMsgToCreateSheetSoapBinding", Namespace = "http://134.64.60.160:85/axis/services/GetMsgToCreateSheet")]
    public partial class GetMsgToCreateSheetService : System.Web.Services.Protocols.SoapHttpClientProtocol
    {

        private System.Threading.SendOrPostCallback getMsgToCreateSheetOperationCompleted;

        /// <remarks/>
        public GetMsgToCreateSheetService()
        {
            this.Url = "http://134.64.60.160:85/axis/services/GetMsgToCreateSheet";
        }

        /// <remarks/>
        public event getMsgToCreateSheetCompletedEventHandler getMsgToCreateSheetCompleted;

        /// <remarks/>
        [System.Web.Services.Protocols.SoapRpcMethodAttribute("", RequestNamespace = "http://C_net_improve.starit.com", ResponseNamespace = "http://134.64.60.160:85/axis/services/GetMsgToCreateSheet")]
        [return: System.Xml.Serialization.SoapElementAttribute("getMsgToCreateSheetReturn")]
        public string getMsgToCreateSheet(string inputXml)
        {
            object[] results = this.Invoke("getMsgToCreateSheet", new object[] {
                    inputXml});
            return ((string)(results[0]));
        }

        /// <remarks/>
        public System.IAsyncResult BegingetMsgToCreateSheet(string inputXml, System.AsyncCallback callback, object asyncState)
        {
            return this.BeginInvoke("getMsgToCreateSheet", new object[] {
                    inputXml}, callback, asyncState);
        }

        /// <remarks/>
        public string EndgetMsgToCreateSheet(System.IAsyncResult asyncResult)
        {
            object[] results = this.EndInvoke(asyncResult);
            return ((string)(results[0]));
        }

        /// <remarks/>
        public void getMsgToCreateSheetAsync(string inputXml)
        {
            this.getMsgToCreateSheetAsync(inputXml, null);
        }

        /// <remarks/>
        public void getMsgToCreateSheetAsync(string inputXml, object userState)
        {
            if ((this.getMsgToCreateSheetOperationCompleted == null))
            {
                this.getMsgToCreateSheetOperationCompleted = new System.Threading.SendOrPostCallback(this.OngetMsgToCreateSheetOperationCompleted);
            }
            this.InvokeAsync("getMsgToCreateSheet", new object[] {
                    inputXml}, this.getMsgToCreateSheetOperationCompleted, userState);
        }

        private void OngetMsgToCreateSheetOperationCompleted(object arg)
        {
            if ((this.getMsgToCreateSheetCompleted != null))
            {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.getMsgToCreateSheetCompleted(this, new getMsgToCreateSheetCompletedEventArgs(invokeArgs.Results, invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }

        /// <remarks/>
        public new void CancelAsync(object userState)
        {
            base.CancelAsync(userState);
        }
    }

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "4.0.30319.1")]
    public delegate void getMsgToCreateSheetCompletedEventHandler(object sender, getMsgToCreateSheetCompletedEventArgs e);

    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("wsdl", "4.0.30319.1")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    public partial class getMsgToCreateSheetCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs
    {

        private object[] results;

        internal getMsgToCreateSheetCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) :
                base(exception, cancelled, userState)
        {
            this.results = results;
        }

        /// <remarks/>
        public string Result
        {
            get
            {
                this.RaiseExceptionIfNecessary();
                return ((string)(this.results[0]));
            }
        }
    }
}