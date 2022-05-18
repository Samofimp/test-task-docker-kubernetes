import requests
import time
import sys
from dateutil.parser import parse
from selenium import webdriver
from selenium.webdriver.common.by import By

# Check if the string can be interpreted as a date
def is_date(string):
    try:
        parse(string)
        return True
    except:
        return False

assert len(sys.argv) == 2
# The script argument must be an url of the tested web page
url = sys.argv[1]
# Get response code, if it equals 200 then web page is served correctly
request = requests.get(url)
response_code = request.status_code
assert response_code == 200
# Use Chrome webdriver for Javascript to work
driver = webdriver.Chrome()
driver.get(url)
# Delay for HTML element to be processed by Javascript
time.sleep(5)
date_to_check = driver.find_element(By.ID, 'date').text
driver.close()
assert is_date(date_to_check)
