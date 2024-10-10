# campus-publications-backend

This project uses [XTF](https://xtf.cdlib.org/). Refer to the XTF documentation for an overview of how that software works. 

Our installation of XTF customizes some stylesheets. queryRouter.xsl routes all requests to the "chicago" query parser. xtf/style/crossQuery/queryParser/chicago and xtf/style/crossQuery/ResultFormatter/chicago contain custom code. Rather than using XTF's XSLT-based template system, we use the system as an search engine, 
transforming it's output into HTML elsewhere.

Data for the project lives in xtf/data/bookreader. Each subdirectory contains OCR data produced by [ocr_converters](https://github.com/uchicago-library/ocr_converters). Those directories also contain a sequence of numbered JPEG pages images (e.g., "00000001.jpg", etc.), a thumbnail image (e.g., "mvol-0001-0002-0003.jpg") a PDF, and a text-only version of the OCR output. Because 
data for the project can be organized differently in different deposits we use 
ad hoc scripts to regularize it and put it in the format we use in XTF. 

In the xtf/bin directory, indexDump can be useful for troublehsooting. To rebuild indexes for the project use the following command:

```console
./textIndexer -clean -index default
```

See [the frontend](https://github.com/uchicago-library/campus-publications) for this project. 
