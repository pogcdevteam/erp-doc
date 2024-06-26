#### Forms

Soemtimes we would like show forms as modals, no matter if it is a create new or edit form. In all that cases we expect the following behvaiour:

1. A modal is shown when user click on ** Create New ** button.
2. If user put invalid data and the form gives errors so we expect the modal to stay in place and not to close.
3. If user puts valid data with a successfull response, the modal disapperas and the list of items is updated.

Consider the following example:

We have the following index.html file :

    <button hx-get="/list-of-items" hx-swap="innerHTML" hx-target="#content" hx-trigger="click">
    List of Items
    </button>
    <div id="content">
    <div>

When user click on the button the content of request will be swapped in inner html of div with id attribute of **content**. 

Consider the response as following:

    <button hx-get="/create-new" hx-swap="innerHTML" hx-target="#content" hx-trigger="click">
    Create New
    </button>
    <div>
    {% for object in object_list %}
    {{object.name}}
    {%endfor%}
    </div>

If the user click on ** Create New** button we would like to a modal form to show up. So we need to modify the above code as below:

    <button hx-get="/create-new" hx-swap="innerHTML" hx-target="#dialog" hx-trigger="click" data-bs-toggle="modal"
          data-bs-target="#staticBackdrop">
    Create New
    </button>
    <div>
    {% for object in object_list %}
    {{object.name}}
    {%endfor%}
    </div>


When user click on **Create New** button the request is sent to server and the folloiwng template that provide a modal form woul dbe rendered.

    {% load django_bootstrap5 %}
    <form hx-post="{{ request.path }}" class="modal-content" enctype="multipart/form-data">
    {% csrf_token %}
        <div class="modal-header">
            <div class="modal-title">Modal Title</div>
            {% include 'minimal/modal-close-button.html' %}
        </div>
        <div class="modal-body"> 
        </div>
        <div class="modal-footer">
            {% include 'minimal/save-button.html' %}
        </div>
    </form>

Now we need to customize our CreateView and make sure the response with statuc code of 204 is returened when data is saved with no error. In order to let htmx know when are going to update the list of items we need to define a custom trigger and use that when we would like to update the list of data. As you see we have defined custom trigger called **exampleChanged**


    class ExampleCreateView(CreateView):
  
        def form_valid(self, form):
            object = form.save(commit = False)
            object.save()
            return HttpResponse(status=204, headers={'HX-Trigger': 'exampleChanged'})

Now we need to add the custom trigger to the the button so our first example will change as following:

    <button hx-get="/list-of-items" hx-swap="innerHTML" hx-target="#content" hx-trigger="click, exampleChanged from:body">
    List of Items
    </button>
    <div id="content">
    <div>


    
    
 