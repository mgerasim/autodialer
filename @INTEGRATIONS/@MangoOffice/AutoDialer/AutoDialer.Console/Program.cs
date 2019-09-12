using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace AutoDialer
{
    class Program
    {
        static void Main(string[] args)
        {
            string base_url = "https://app.mango-office.ru/vpbx";
            string command_url = "/config/users/request";
            string vpbx_api_key = "bx87j76eaoet53vhyd06qae4ksbhf89g";
            string vpbx_api_salt = "v8e56aa6peql8btxejtvkxpugq2lo1sa";

            string json = "{}";

            string sign = Sign(vpbx_api_key, json, vpbx_api_salt);

            Console.WriteLine(sign);

            HttpClient httpClient = new HttpClient();

            var values = new Dictionary<string, string>
            {
                { "vpbx_api_key", vpbx_api_key },
                { "sign", sign },
                {"json", "{}" }

            };

            var content = new FormUrlEncodedContent(values);

            var response = httpClient.PostAsync(base_url + command_url, content).Result;

            var responseString = response.Content.ReadAsStringAsync().Result;

            Console.WriteLine(responseString);
        }

        /// <summary>
        /// Формирует подпись запроса
        /// </summary>
        /// <param name="vpbx_api_key"></param>
        /// <param name="json"></param>
        /// <param name="vpbx_api_salt"></param>
        /// <returns></returns>
        static string Sign(string vpbx_api_key, string json, string vpbx_api_salt)
        {
            string result = sha256(vpbx_api_key + json + vpbx_api_salt);

            return result;
        }

        /// <summary>
        /// Расчитывает хеш SHA256
        /// </summary>
        /// <param name="randomString"></param>
        /// <returns></returns>
        static string sha256(string randomString)
        {
            var crypt = new SHA256Managed();
            string hash = String.Empty;
            byte[] crypto = crypt.ComputeHash(Encoding.ASCII.GetBytes(randomString));
            foreach (byte theByte in crypto)
            {
                hash += theByte.ToString("x2");
            }
            return hash;
        }
    }
}
