# InnoMemorizerApp <img src="assets/icons/icon.png" height="50"/>
___

IMP - an innovative open source application that helps people memorize text more easily. InnoMemorizerApp allows you to control memorizing process with your voice. Currently it is available only for Android. \
[![GitHub Super-Linter](https://github.com/InnoSWP/InnoMemorizerApp/workflows/Lint%20Code%20Base/badge.svg)](https://github.com/marketplace/actions/super-linter) \
<img src="assets/images/gif.gif" height="100"/></h1>

___
## ⬇️ Available
[<img src="assets/icons/apk.gif" height="100"/>](https://drive.google.com/file/d/15I3s-XHqV14yyn8KTOzr_W4EnYBbq7Mh/view?usp=sharing "APK link")

## 📺 Demo video

[<img src="assets/icons/video.png" height="100"/>](https://youtube.com/shorts/QQ22qtIBW9E "DEMO")

___
## 🏠 Pages

<table>
<tr>
<td>

### 📤 Upload page
<p>
    Home page provides an opportunity <br>
    to upload text in 2 different ways. <br>
    First of which is uploading .pdf <br>
    file in the <b>Upload</b> section. <br>
    The file will be parsed to plain text <br>
    using an external API.
</p>

</td>
<td>
    <img src="https://github.com/InnoSWP/InnoMemorizerApp/blob/main/assets/screens/upload.png?raw=true" alt="upload page" width="200"/>
</td>
</tr>
    
<tr>
<td>

### 📥 Type page 
<p>
    Another option to upload text is <br>
    to type text in the <b>Type</b> section. <br>
    When you are done uploading text, <br>
    click on <b>Start memorize</b>. <br>
    This will initialize parsing of the <br>
    plain text to sentences using an <br>
    external API or embedded algorithm <br>
    if the first one is not available.
</p>

</td>
<td>
    <img src="https://github.com/InnoSWP/InnoMemorizerApp/blob/main/assets/screens/paste.png?raw=true" alt="type page" width="200"/>
</td>

</tr>
    
<tr>
<td>
    
### ✨ Memorizing page
<p>    
    The memorizing page shows title <br>
    of the text and the parsed sentences. <br>
    <b>Play/stop</b> - plays and stops on <br>
    the current highlighted sentence. <br>
    <b>Forward, rewind</b> - goes back and <br>
    forth by 1 sentence. <br>
    <b>Repeat</b> - repeats the current <br>
    sentence until disabled.

</p>
</td>

<td>
    <img src="https://github.com/InnoSWP/InnoMemorizerApp/blob/main/assets/screens/memorize.png?raw=true" alt="memorizing page" width="200"/>
</td>
        
</tr>
</table>

___
## 🔭 Used packages, libraries and APIs
- flutter/material
  - flutter/services
- dio/dio
- alan_voice/alan_voice
- dart/convert
- toggle_switch/toggle_switch
- pdf_text/pdf_text
- file_picker/file_picker
- dotted_border/dotted_border
- shared_preferences/shared_preferences

___
## ✨ Features

| Feature                                       | Supported | 
|-----------------------------------------------|:---------:|
| Type text for memorize                        |     ✅     |
| Upload PDF for memorize                       |     ✅     |
| Highlight current sentence                    |     ✅     |
| Add buttons to go to previous/next sentence   |     ✅     |
| Add buttons to pause/stop/repeat sentence     |     ✅     |
| Interface to write number of repetitions      |     ✅     |
| Playback sentences for memorize               |     ✅     |
| Processing of voice commands via Alan platform|     ✅     |
| Repeating by blocks                           |     ❌     |
| Adaptation of different voice tones           |     ❌     |
| Increased features in the app settings        |     ❌     |
| Add new memorize techniques                   |     ❌     |

___
## Donate

<a href="https://www.buymeacoffee.com/timurx4041" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="82" width="348"></a>
