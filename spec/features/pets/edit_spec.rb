# As a visitor
# When I visit a Pet Show page
# Then I see a link to update that Pet "Update Pet"
# When I click the link
# I am taken to '/pets/:id/edit' where I see a form to edit the pet's data including:
# - image
# - name
# - description
# - approximate age
# - sex
# When I click the button to submit the form "Update Pet"
# Then a `PATCH` request is sent to '/pets/:id',
# the pet's data is updated,
# and I am redirected to the Pet Show page where I see the Pet's updated information