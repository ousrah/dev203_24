

# this page is to control my app


# Flask is a web framework for Python.
# You import it to create a Flask web application,
# render HTML templates, handle redirects, process HTTP requests,
# and return JSON responses.

# CORS stands for (Cross-Origin Resource Sharing)
# CORS is used to handle cross-origin requests.
# It's essential for allowing your web application to make requests to a server that is on a different domain.

from flask import Flask, render_template, redirect, request, jsonify
from flask_cors import CORS
from pymongo import MongoClient
from bson import ObjectId  # Import ObjectId




# initializing a Flask web application.

# Flask(__name__):

# __name__ is a special variable in Python that represents the name of the current module.
# When used in the context of a Flask application, it helps Flask to determine the root path of the application.
# This line creates a Flask web application instance named app.

# template_folder='views':
# This parameter specifies the folder where Flask should look for templates (HTML files). In this case, it's set to 'views'.

# static_folder='public':
# This parameter specifies the folder where Flask should look for static files (like CSS, JavaScript, or images). In this case, it's set to 'public'.
# Static files are files that don't change and can be served directly to the client without modification.

app = Flask(__name__, template_folder='views', static_folder='public')

CORS(app)

# Connect to MongoDB

# https://cloud.mongodb.com/v2/65049a8b52227656cc86d28a#/metrics/replicaSet/65049b3bef03f87d7a4347df/explorer/al-d/article/find

# mongodb+srv://zefri-mohammad:<password>@cluster0.9yt5lmr.mongodb.net/the-name-of-the-database?retryWrites=true&w=majority

client = MongoClient('mongodb+srv://zefri-mohammad:000001@cluster0.9yt5lmr.mongodb.net/al-d?retryWrites=true&w=majority')
db = client['al-d']




# (@app.route(...)) to handle different HTTP requests and interact with the MongoDB database

@app.route("/")
def home():
    return redirect("/all-articles")

@app.route("/all-articles")
def all_articles():
    # Use pymongo to interact with MongoDB
    articles = list(db.article.find())
    return render_template("index.html", mytitle="HOME", arrArticle=articles)

@app.route("/add-new-article")
def add_new_article():
    return render_template("add-new-article.html", mytitle="create new article")


# Add an article
@app.route("/all-articles", methods=["POST"])
def create_article():
    new_article = {
        'title': request.form.get("title"),
        'summary': request.form.get("summary"),
        'content': request.form.get("body")
    }
    # Use pymongo to insert data into MongoDB
    db.article.insert_one(new_article)
    return redirect("/all-articles")


# Display the details of a specific article
@app.route("/all-articles/<id>")
def article_details(id):
    # Convert the id to ObjectId
    # Get the id of the article i want to delete
    object_id = ObjectId(id)
    # Use pymongo to retrieve data from MongoDB
    # Find the article using its id
    article = db.article.find_one({'_id': object_id})
    return render_template("details.html", mytitle="ARTICLE DETAILS", objArticle=article)


# Delete an article
@app.route("/all-articles/<id>", methods=["DELETE"])
def delete_article(id):
    # Convert the id to ObjectId
    object_id = ObjectId(id)
    # delete_one()  
    db.article.delete_one({'_id': object_id})
    return jsonify({"mylink": "/all-articles"})


# Handling of the 404 response
# 404
# Define an error handler for 404 errors,
# displaying a simple message when a requested page is not found
@app.errorhandler(404)
def page_not_found(e):
    return "Sorry, the requested page was not found.", 404

# Run the app when the script is executed
if __name__ == "__main__":
    app.run(debug=True)
