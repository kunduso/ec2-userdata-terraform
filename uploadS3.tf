// To upload one artifact
// resource "aws_s3_bucket_object" "object" {
//   bucket = "skundu-proj3-3p-installers"
//   key    = "download/Hello.txt"
//   source = ".\\files\\*.*"
// }
// To upload multiple artifacts
resource "aws_s3_bucket_object" "object" {
for_each = fileset("files/", "*")
bucket = "skundu-proj3-3p-installers"
key = format("download/%s", each.value)
source = "files/${each.value}"
}