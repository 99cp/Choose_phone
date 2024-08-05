from webdriver_manager.chrome import ChromeDriverManager
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.common.exceptions import NoSuchElementException
import time
import psycopg2
import re
i = 1
conn = psycopg2.connect(host='localhost', dbname='dayseop',user='postgres',password='1234',port=5432)

conn.autocommit = True
cur = conn.cursor()
cur.execute("DROP TABLE Product")
cur.execute("CREATE TABLE Product(Prod_NAME VARCHAR(255) PRIMARY KEY, Prod_PRICE INT, Prod_battery INT, Prod_memory INT, Prod_camera INT, Prod_size INT, Prod_storage INT, Prod_URL VARCHAR(255), Prod_Image VARCHAR(255))")

while True:

    options = webdriver.ChromeOptions()
    UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36"
    
    options.add_argument('user-agent' + UserAgent)
    driver = webdriver.Chrome()
    driver.get(url = 'https://search.danawa.com/dsearch.php?query=%EC%8A%A4%EB%A7%88%ED%8A%B8%ED%8F%B0&originalQuery=%EC%8A%A4%EB%A7%88%ED%8A%B8%ED%8F%B0&previousKeyword=%EC%8A%A4%EB%A7%88%ED%8A%B8%ED%8F%B0&includeKeyword=%EC%9E%90%EA%B8%89%EC%A0%9C&volumeType=allvs&page='+str(i)+'&limit=120&sort=saveDESC&list=list&boost=true&addDelivery=N&makerbrand_name=%EC%82%BC%EC%84%B1%EC%A0%84%EC%9E%90%7CAPPLE&recommendedSort=Y&defaultUICategoryCode=12215709&defaultPhysicsCategoryCode=224%7C48419%7C48829%7C0&defaultVmTab=617&defaultVaTab=1278&isZeroPrice=N&tab=main')

    time.sleep(5)
    try:
        product = driver.find_element(By.CLASS_NAME, 'product_list')
        lis = product.find_elements(By.CLASS_NAME, 'prod_main_info')
        
        print ('*' * 50 + ' ' + str(i) + 'Page Start!' + ' ' + '*' * 50)
        for li in lis:
            try:
                product = li.find_element(By.CLASS_NAME, 'prod_name').text
                pricesect = li.find_element(By.CLASS_NAME, 'price_sect')
                price1 = pricesect.find_element(By.TAG_NAME, 'a').text
                price = re.sub(r"[^0-9]", "", price1)
                spec = li.find_element(By.CLASS_NAME, 'spec_list').text
                urlsect = li.find_element(By.CLASS_NAME, 'prod_name')
                url = urlsect.find_element(By.TAG_NAME, 'a').get_attribute('href')
                imagesect1 = li.find_element(By.CLASS_NAME, 'thumb_image')
                image = imagesect1.find_element(By.TAG_NAME, 'img').get_attribute('src')
                if image == 'https://img.danawa.com/new/noData/img/noImg_160.gif':
                    image = imagesect1.find_element(By.TAG_NAME, 'img').get_attribute('data-src')
                
                if product:                    
            
                    b1 = re.sub(r"[^0-9/^mAh$]", "", spec)
                    b2 = b1.split('/')
                    b3 = [word for word in b2 if 'mAh' in word]
                    b4 = '/'.join(b3)
                    battery = re.sub(r"[^0-9]", "", b4)

                    m1 = re.sub(r"[^0-9/^램:$]", "", spec)
                    m2 = m1.split('/')
                    m3 = [word for word in m2 if '램:' in word]
                    m4 = '/'.join(m3)
                    memory = re.sub(r"[^0-9]", "", m4)

                    c1 = re.sub(r"[^0-9./^+후면:$]", "", spec)
                    c2 = re.sub(r"1.08", "10800", c1)
                    c3 = re.sub(r"[+]", "/", c2)
                    c4 = c3.split('/')
                    c5 = [word for word in c4 if '후면:' in word]
                    c6 = '/'.join(c5)
                    camera = re.sub(r"[^0-9]", "", c6)

                    s1 = re.sub(r'[^0-9./()"^cm$]', "", spec)
                    s2 = s1.split('/')
                    s3 = '('.join(s2)
                    s4 = s3.split('(')
                    s5 = ')'.join(s4)
                    s6 = s5.split(')')
                    s7 = [word for word in s6 if '"' in word] 
                    s8 = '/'.join(s7)
                    s9 = re.sub(r'["]', "", s8)
                    size = re.sub(r"[^0-9]", "", s9)
                    
                    st1 = re.sub(r"[^0-9/^내장:$]", "", spec)
                    st2 = st1.split('/')
                    st3 = [word for word in st2 if '내장:' in word]
                    st4 = '/'.join(st3)
                    storage = re.sub(r"[^0-9]", "", st4)

                    insertcur = ("INSERT INTO Product (Prod_NAME, Prod_PRICE, Prod_battery, Prod_memory, Prod_camera, Prod_size, Prod_storage, Prod_URL, Prod_Image) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)")
                    data = (product, price, battery, memory, camera, size, storage, url, image)
                    cur.execute(insertcur, data)
                
            except Exception:
                pass

        print ('*' * 50 + ' ' + str(i) + 'Page End!' + ' ' + '*' * 50)
        time.sleep(5)
        i += 1
        driver.quit()

    except NoSuchElementException:
        exit(0)