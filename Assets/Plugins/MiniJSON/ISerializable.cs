using System;
using System.Collections.Generic;
using System.Linq;
using MiniJSON;


namespace Utils.Serialization
{
    public interface ISerializable
    {
        JSONObject ToJson();
        void FromJson(JSONObject json);
    }

    
    public static class SerializableExtensions
    {
        public static T CreateFromJson<T>(JSONObject json) where T : ISerializable, new()
        {
            var o = new T();
            o.FromJson(json);
            return o;
        }

        public static JSONObject CopyFields(this JSONObject to, JSONObject from, IEnumerable<string> exceptKeys = null)
        {
            foreach (var kvp in from)
            {
                if (exceptKeys == null || !exceptKeys.Contains(kvp.Key)) to.Add(kvp);
            }
            return to;
        }
    }
    
}