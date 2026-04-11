import requests
import httpx

import httpx
import mimetypes


def get_content_type(filename):
    """根据文件名获取Content-Type"""
    content_type, encoding = mimetypes.guess_type(filename)
    return content_type or 'application/octet-stream'  # 如果无法识别，返回默认值


url = "http://localhost:10022/filemanage/upload_form"
# url = 'http://localhost:5437/api/common/file/upload'

filename = '{B4EE7B5F-86F1-D708-C20F-AFCD526E6CCB}.png'

files = {
    'metadata': ('', '{}', 'text/plain'),
    'bucketName': ('', 'dataset', 'text/plain'),
    'file': (filename, open(filename, 'rb'), get_content_type(filename)),
    'data': ('', '{"datasetId": "69abf6fc85b03b49dec952a4"}', 'application/json')
}

# cookies如下：NEXT_LOCALE=zh-CN; session=MTc3Mjg2NzA0MXxEWDhFQVFMX2dBQUJFQUVRQUFCc180QUFCQVp6ZEhKcGJtY01DZ0FJZFhObGNtNWhiV1VHYzNSeWFXNW5EQVlBQkhKdmIzUUdjM1J5YVc1bkRBWUFCSEp2YkdVRGFXNTBCQU1BXzhnR2MzUnlhVzVuREFnQUJuTjBZWFIxY3dOcGJuUUVBZ0FDQm5OMGNtbHVad3dFQUFKcFpBTnBiblFFQWdBQ3z2nUjiRRxLtIInVp9pPOlevLoy5Z1JcC3tC8YmCnsl_Q==; jetai_token=699d69b06a7a4e90f1aa6487:sOnMguxzmQzu1emqxMtoHtczPkXdVWBH; NEXT_DEVICE_SIZE=pc
headers = {
    "Cookie": "NEXT_LOCALE=zh-CN; session=MTc3Mjg2NzA0MXxEWDhFQVFMX2dBQUJFQUVRQUFCc180QUFCQVp6ZEhKcGJtY01DZ0FJZFhObGNtNWhiV1VHYzNSeWFXNW5EQVlBQkhKdmIzUUdjM1J5YVc1bkRBWUFCSEp2YkdVRGFXNTBCQU1BXzhnR2MzUnlhVzVuREFnQUJuTjBZWFIxY3dOcGJuUUVBZ0FDQm5OMGNtbHVad3dFQUFKcFpBTnBiblFFQWdBQ3z2nUjiRRxLtIInVp9pPOlevLoy5Z1JcC3tC8YmCnsl_Q==; jetai_token=699d69b06a7a4e90f1aa6487:sOnMguxzmQzu1emqxMtoHtczPkXdVWBH; NEXT_DEVICE_SIZE=pc"
}

response = httpx.post(url, files=files, headers=headers)
print(response.status_code)
print(response.text)




