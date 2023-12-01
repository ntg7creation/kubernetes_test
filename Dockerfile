# was 3.9 it should be fine as we install it per docker
FROM python:3.9

# folder inside the docker where to place the code
WORKDIR /code

# cody the requirements 
COPY ./requirements.txt /code/requirements.txt

# 
RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

# 
COPY ./app /code/app

# I think the "--port", "81" is the vertuial ip 
#while the port 8000 (or anyother) is giving with the run command when we start the image 
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "81"]
