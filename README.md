# DICacheMasterFramework
Swift Image Cache Utility Library

This is a library is intended to to abstract the downloading (images, pdf, zip, etc) and caching of remote resources (images, JSON, XML, etc), as per the requirements.

To install it on a project(or a framework), simply following steps :

<strong>Carthage </br></strong>

First make sure you installed Carthage, then :
</br>
</br>
<code>cd ~/Path/To/Starter/Project</code>
</br>
</br>
then </br>
<code>touch Cartfile</code>
</br>
</br>
then </br>
<code>open -a Xcode Cartfile</code>
</br>
</br>
then
</br>
add following line <code>github "braxmarelax/DICacheMasterFramework"</code> on your cartfile. </br>
 </br>Next, don't forget to drag and drop the DICacheMasterFramework.framework from ~/Path/To/Starter/Project/Cathage/⁨Build⁩/⁨iOS⁩ to your General->Linked Frameworks and Libraries then adding it on Build phase->Embed frameworks and Build phase->Link binary with Libraries. </br></br> 

These are standart carthage integration steps.</br>

<strong>What is completed :</strong></br></br>
-> Loading data from : http://pastebin.com/raw/wgkJgazE (and all links which return a json with the same structure and this link) and showing a slider image view to show the content(with <code>FileCacher.displayImageGrid(vc:UIViewController, API_URL:String)</code>);

-> Images are cached efficiently(with <code>FileCacher.cacheImage(url:String!,uiImageView:UIImageView)</code>

-> The cache have a configurable max capacity and should evict images not recently used (with method <code>FileCacher.initCache(memoryCacheSizeInMega:Int,imageNumberLimit:Int, expirationTimeInSecond:Int)</code>

-> An image load can be cancelled (with <code>FileCacher.cancelDownload(uiImageView:UIImageView</code>)

-> The same image can be requested by multiple sources simultaneously (even before it has loaded), and if one of the sources cancels the load, it should not affect the remaining requests;

-> Multiple distinct resources can be requested in parallel;

-> The library should be easy to integrate into new iOS project / apps (Simply with standart carthage integration);

-> Cool animations and transitions integrated for image loading and dialogs;

<strong>What remain to be done :</strong>

-> Think that the list of item returned by the API can reach 100 items or even more. At a time, you should only load 10 items, and load more from the API when the user reach the end of the list;

-> Adding "pull to refresh"

-> Adding caching for other file type (XML,JSon,...) and download for (pdf, zip,...) files

-> Implementing Test Classes
