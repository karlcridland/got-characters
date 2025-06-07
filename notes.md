# Take home test notes

## Steps I took:

### 1. Fix crash. 

- Decoding of characters was force unwrapped, putting this in a try/catch block and logging the error told me an [Int] value was expected but was receiving a [String] value instead for "aliases" in Character struct -> switched this to correct type and it fixed the issue.

### 2. Decoupling the View Controller. 

- Separated logic from view controller into a CharacterManager class to clean up the structure. Will also be used for the search feature. This will really help with scalability in the future for other people who could potentially come in to edit the code.

### 3. Search feature. 

- Implemented SearchBarView both in storyboard and in file structure, and integrated it into the view controller/character manager. 

- Constraints added so it sits at top of safe area in the view, table view top constraint changed to sit below the search bar.

### 4. Further structure improvement and Unit Testing. 

- Introduced an MVVM architecture through the CharactersViewModel class, also improved error handling by placing it inside the modelView.

- Added unit testing to project to make sure changes were okay,  I added test cases for character decoding and searching.

### 5. Design matching. 

- Noticed the differences in styling between the two different versions, in mockup: name looks bigger, attributes (seasons, culture, born, died) are all a higher weight than code supplied. 

- Number of lines on Eddard Stark entry doesn't truncate. Number of lines didn't fix this, so needed constraints update.

- Roman numeral for the seasons was in a big if/else nested block, removed that for a cleaner string array join after mapping the values (probably a cleaner way to do this still, but thought it was a good enough improvement for purposes of take home test).

## What could be done to improve further?

- A better search method could be implemented to better normalise results and give weight to them.

- "Died" label is center aligned to value, in the spec is it top aligned - it does say it doesn't need to be pixel perfect so I'm happy to ignore.

## Final comments

- One of the issues reported was white padding, I couldn't see white padding in the specs anywhere?? I'm presuming this is either a red herring or in regards to the font weight for the attributes?  

- Ideally I would have liked to clear the warnings down to 0, but the constraints are laid out well enough before I overrun on time.

- I didn't use any branches on my version control as it was a fairly linear task.

- Enjoyed myself! Definitely one of the nicer coding assignments, thank you :)
