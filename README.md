# Tutorial that practices PDF scraping and file upload

Contains Robocorp robot which uses the tutorial website from https://www.rpa-unlimited.com/. 

This robot is a good example on how you can extract data from a PDF file, use this data to navigate to a page and upload the same PDF file. This particular example extracts the Order Number from the PDF file, looks up the Order Number in a database and finally uploads the PDF File.

## Robot steps

  1. Navigate to website
  2. Download PDF files
  3. List Files In Download Directory
  4. Find order number from PDF file
  5. Perform search using order number
  6. Upload PDF file
  7. Go back to front page and repeat until all files have been uploaded

## Links
- [RPA Unlimited website](https://www.rpa-unlimited.com/uipath-rpa-beginners-course/chapter9-files-and-pdf/client.php?id=1)