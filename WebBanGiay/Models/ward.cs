//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WebBanGiay.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class ward
    {
        public string code { get; set; }
        public string name { get; set; }
        public string name_en { get; set; }
        public string full_name { get; set; }
        public string full_name_en { get; set; }
        public string code_name { get; set; }
        public string district_code { get; set; }
        public Nullable<int> administrative_unit_id { get; set; }
    
        public virtual administrative_units administrative_units { get; set; }
        public virtual district district { get; set; }
    }
}
