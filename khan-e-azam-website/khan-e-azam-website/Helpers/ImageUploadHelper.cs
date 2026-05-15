using System;
using System.IO;
using System.Web;

namespace KhanEAzam.Helpers
{
    public static class ImageUploadHelper
    {
        private static readonly string[] Allowed = { ".jpg", ".jpeg", ".png", ".gif", ".webp" };
        private const long MaxBytes = 5 * 1024 * 1024; // 5 MB

        /// <summary>
        /// Saves the posted file to the uploads folder and returns the relative web path,
        /// e.g. "assets/images/uploads/abc123.jpg". Returns null on invalid input.
        /// </summary>
        public static string Save(HttpPostedFile file, string serverFolder)
        {
            if (file == null || file.ContentLength == 0) return null;
            if (file.ContentLength > MaxBytes) return null;

            string ext = Path.GetExtension(file.FileName).ToLowerInvariant();
            if (Array.IndexOf(Allowed, ext) < 0) return null;

            if (!Directory.Exists(serverFolder))
                Directory.CreateDirectory(serverFolder);

            string fileName = Guid.NewGuid().ToString("N") + ext;
            file.SaveAs(Path.Combine(serverFolder, fileName));
            return "assets/images/uploads/" + fileName;
        }
    }
}
