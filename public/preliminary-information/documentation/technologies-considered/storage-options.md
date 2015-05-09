Here are the most prevalent options.
Prices assume a need for 4Tb, and 10 thousand requests per month (which we suppose here amounts to 20Gb of bandwidth per month)

 Provider               | Storage | Requests | Bandwidth | total | Server | Redundancy | Image Processing 
 ---------------------- | ------- | -------- | --------- | ----- | ------ | ---------- | ---------------- 
 [Amazon S3][p1]        |   94$   |   0.004$ |   1.8$    |   96$ |   (✓)  |     (✓)    |       (x)        
 [Amazon Glacier][p3]   |   40$   |   000$   |   000$    |   40$ |   (x)  |     (✓)    |       (x)        
 [Dropbox Business][p4] |   75$   |   000$   |   000$    |   75$ |   (x)  |     (✓)    |       (x)       
 [Joyent Manta][p5]     |  144$   |   0.004$ |   0.120$  |  145$ |   (✓)  |     (x)    |       (✓)        
 [Joyent Manta+][p5]    |  288$   |   0.004$ |   0.120$  |  289$ |   (✓)  |     (✓)    |       (✓)        
 [MediaFire][p2]        |   89$   |   000$   |   000$    |   89$ |   (✓)  |     (✓)    |       (x)        
 [Google Drive][p8]     |   99$   |   000$   |   000$    |   99$ |   (✓)  |     (✓)    |       (x)        
 [Microsoft Azure][p9]  |   94$   |   000$   |   000$    |   94$ |   (x)  |     (✓)    |       (x)        
 [So You Start][p10]*   |   69$   |   000$   |   000$    |   69$ |   (✓)  |     (x)    |       (x)        
 [BlackBlaze][p11]      |    5$   |   000$   |   000$    |    5$ |   (x)  |     (x)    |       (x)        
 [Your-Server][p7]*     |   30$   |   000$   |   000$    |   30$ |   (✓)  |     (✓)    |       (x)        
 [Mega][p14]            |   30$   |   000$   |   000$    |   30$ |   (✓)  |     (✓)    |       (x)        
 [Box][p8]              |   51$   |   000$   |   000$    |   51$ |   (✓)  |     (✓)    |       (x)        
 [ImageFly][p12]        |  000$   |   000$   |   150$    |  150$ |   (✓)  |     (x)    |       (✓)        

<small>* = self managed</small>

## Notes

#### [Dropbox for Businesses][p4]
Has a bandwidth hard limit of 200Gb/day

#### [Google Drive][p8]
Has a bandwidth hard limit of 1Gb/day

#### [ImageFly][p12]
Creates versions of the images automatically, has a CDN

----

## Honorable mentions:

#### [DreamHost][p5]
Has a 35$ plan, but limited to 2Tb. Has a 20Tb plan, at 300$.

#### [Cloudinary](http://cloudinary.com/pricing)
free for 2Gb storage, 5Gb bandwidth

#### [ShrinkRay](https://shrinkray.io/)
Optimizes automatically images in a github repo

#### [Dropbox Pro](https://www.dropbox.com/business/pricing)
10$/m, but only 1Tb of space

#### [Iris Couch](https://www.iriscouch.com/service)
Bundles a CouchDB database, but 1$/gig. No other fees though
 
[p1]:http://aws.amazon.com/s3/pricing/ 
[p2]:https://www.mediafire.com/upgrade/#space
[p3]:http://aws.amazon.com/glacier/
[p4]:https://www.dropbox.com/business/pricing
[p5]:https://www.joyent.com/object-storage/pricing
[p6]:https://www.dreamhost.com/cloud/storage/
[p7]:https://robot.your-server.de/order/market/country/OTHER
[p8]:https://www.box.com/pricing/
[p9]:http://azure.microsoft.com/en-gb/pricing/details/storage/
[p10]:http://www.soyoustart.com/us/disk/
[p11]:https://www.backblaze.com/
[p12]:http://imagefly.io/