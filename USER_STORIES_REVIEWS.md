#create

As an authenticated user
I want to add a review for a restaurant
So that I can share with others my thoughts about that restaurant

[] I must be signed in
[] If user is not signed in, user will be prompted to sign in
[] My review must include ratings for all 4 key attributes
[] I can leave an optional comment
[] When I submit my review, I can see it on the restaurant's detail page
[] I must be presented with errors if I leave an invalid review
[] If all is good, I get a successfully submitted message

#index

As an unauthenticated user
I want to see all the reviews for a restaurant
So that I can decide if I'd want to have a date there

[] I do not need to be an unauthenticated user
[] I can see all the reviews on the restaurant's details page

#update

As an authenticated user
I want to be able to changed my review
To reflect any new feelings I might have about a restaurant

[] I must be signed in
[] If I'm not signed in, I should be prompted to do so
[] I can only edit my own reviews
[] The Edit Review form is autofilled with my original review/rating
[] When I submit my changes, I can see them on the restaurant's detail page
[] I get a successfully updated message

#delete

As an authenticated user
I want to be able to delete my review
Because I no longer want that review on the site

[] I must be signed in
[] If I'm not signed in, I should be prompted to do so
[] I can only delete my own reviews
[] I delete by clicking on the delete button in the Edit Profile page
[] I am prompted to confirm the deletion
[] I get a successfully deleted message
[] I no longer see my review on the Restaurant's show page
