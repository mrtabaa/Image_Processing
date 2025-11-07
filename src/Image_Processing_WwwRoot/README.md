#### Updates:
- v1.1.0 => v1.1.1:
    - No code is being changed. Only some GitHub links are fixed.
---
# Hallboard.SkiaSharp.ImageProcessing.WwwRoot

Cross-platform image processing utility for ASP.NET Core applications, powered by **SkiaSharp**.

This library provides high-performance methods for:
- Resizing images (by scale, pixel, or square)
- Cropping (centered or square)
- WebP encoding for web delivery
- Optimized file saving under `wwwroot/storage/photos/{userId}`

---

## 🚀 Installation

```bash
dotnet add package Hallboard.SkiaSharp.ImageProcessing.WwwRoot


🧱 Example Usage
```c#
using Hallboard.SkiaSharp.ImageProcessing.WwwRoot;
using Microsoft.AspNetCore.Http;

public class PhotosController : ControllerBase
{
    private readonly IPhotoModifySaveService _photoService;

    public PhotosController(IPhotoModifySaveService photoService)
    {
        _photoService = photoService;
    }

    [HttpPost("resize")]
    public async Task<IActionResult> Resize(IFormFile file)
    {
        string path = await _photoService.ResizeByPixel(file, "user-123", 800, 600);
        return Ok(new { Saved = path });
    }
}

```