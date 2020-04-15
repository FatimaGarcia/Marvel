# Marvel
Marvel's character list and detail using Marvel API. 

<p align="left">
<img src="https://github.com/FatimaGarcia/Marvel/blob/master/Sample/List.png" width="300" height="450">
<img src="https://github.com/FatimaGarcia/Marvel/blob/master/Sample/List-search.png" width="300" height="450">
<img src="https://github.com/FatimaGarcia/Marvel/blob/master/Sample/Detail.png" width="300" height="450">
</p>

### Requirements
- iOS 13.0+
- Swift 5
---
### Notes
- Characters on the list are displayed 5 by 5. Show more button is included at the end of the list. 
- Three parameters are needed to invoke Marvel APIs : public key, timestamp and hash (generate from the timestamp, private key and public key).  In order to not include API's private key on the code, timestamp and hash value are included as constants in the code for this sample. 
- Third party libraries included:  Alamofire for networking, Kingfisher for caching character's images. 


