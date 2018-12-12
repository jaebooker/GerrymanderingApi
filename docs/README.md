# Welcome to the Gerrymandering API!

> Get all information on elected representatives who have voted for gerrymandering in the US

>Or add ones who have to the API

>Or participate in our new blockchain, by adding information a politicians actions regarding gerrymandering, voter suppression, or even actions taken to stop these things. Once its on the blockchain, it can never be censored by any government.

>If you're are wondering what gerrymandering is, don't worry! Many people don't, which is how they get away with it.
>For more information, you can start by reading this fantastic article on Wired: https://www.wired.com/2017/04/gerrymandering-illegal-mathematicians-can-prove/

>If you have a Washington Post subscription, this article is very useful as well:
https://www.washingtonpost.com/news/wonk/wp/2015/03/01/this-is-the-best-explanation-of-gerrymandering-you-will-ever-see/?utm_term=.0b1c73980b2a
# Getting the Gerrymandering List
>To get the gerrymandering list, simply enter the following endpoint as a GET request:
>https://gerrymanderingapi.herokuapp.com/gerrymandering

>This will return a list of all elected officials who have voted or authored legislation approving gerrymandered districts.
>It's that simple!

# Posting to the Gerrymandering List
>Okay, you've decided to be proactive by adding to our database, good for you! We're always looking for new volunteers!

>To start off, you're going to need to register an account. We know, we know, it's tedious, but it has to be done. This is the only way we can keep track of who is adding accurate information, and who isn't.

>To start, enter the endpoint https://gerrymanderingapi.herokuapp.com/api/users/register, and make it a POST

>Then pass in the JSON body the following:

>
    {
    "email": "your@email.com",

    "password": "yourpassword"
    }

>And that's it! After that, you're in! Now to post actual data.

>Go to https://gerrymanderingapi.herokuapp.com/gerrymandering, making it a POST again, and put the following in the body:

>
    {
    "name": "full name of official",
    "officeType": "Senator/State Senator/etc.",
    "representing": "Texas/1st District Maryland/etc."
    }

>And that's it! You've helped shine a light on people trying to vandalize our system.

# Adding Information to the Blockchain

>Hmmmm... you didn't come here just because you heard we have a blockchain, did you?

"No, of course not"

>Good! But now that you're here, we actually could use you to help build this thing! Here's the rundown of how it works.
>You register an endpoint as a node.

"Stop, I'm already confused."

>That's okay! There's a ton of information about this on the internet, but I'd recommend starting with these:
https://medium.freecodecamp.org/explain-bitcoin-like-im-five-73b4257ac833
https://medium.com/@jaesonbooker/after-the-hunt-how-to-hunt-a-mammoth-part-ii-db969f8cfdb
https://medium.com/@jaesonbooker/one-ring-signature-to-rule-them-all-ac18964de6d3

"Hmmm... wait, did you just add a few of your own articles to give yourself some publicity?"

>...maaaaybe.
>But, anyway, so you register a server location as a node. This can be any publicly accessible address. As long as we can talk to it, it's gold! Here's how we do it:

>Go to the endpoint https://gerrymanderingapi.herokuapp.com/nodes/register, once again making a POST request, and enter the following (make sure to also add your login credentials, email/password. You're going to need to authenticate to participate here):

>
    [{
	"address": "http://youraddress"
    }]

>And that's it! If you want to add more addresses, that's fine! Many do. Just separate each with a comma the way you would with any JSON data. Now that you're address is registered, you can start adding to the blockchain by "mining"!

>The blockchain as more detail than the normal list, because we want to share information that can never be deleted or censored. This is information to use as reference, rather than simply getting a quick list of people. Here's what you'll be passing in.

>On the https://gerrymanderingapi.herokuapp.com/mine endpoint, enter the following:

>
    {
    "firstName": "John"
    "lastName": "Smith"
    "officeType": "Senator"
    "representing": "California, 3rd District"
    "zipcodes": 21801, etc. Numbers, not strings.
    "gerrymandering": either true or false (lowercase, no quotes)
    "voterSuppression": same as above
    supportingEvidence: "Supporting articles, etc. All a string."
    }

>Okay, that's a lot. Let's go over it.

>So you enter the politicians' first and last name. Simple enough.

>Then you add the office type (State Senator, etc.) that they are currently holding. We don't really care about people from the past, since their no longer serving and don't need to be kicked out. Nor are talking about people who are running, since no one campaigns on the promise of gerrymandering districts.

>Next, there's the zip codes. These are the zip codes for the areas the person represents. You don't have to put them in, since they are optional (the only entry that is optional, all others are required). The usefulness is that someone could enter their zip code and instantly get information on those representing them. But again, this one's up to you.

>Gerrymandering and Voter Suppression. These are yes or now. They are not 'truthy'. We want either a true or false. If they voted for approving redistricting that has been deemed by independent sources to be gerrymandered in favor of a certain party, or else authored (or co-authored) such a bill or drew the maps, then answer true on Gerrymandering. Otherwise, answer false. If they voted for, authored, or co-authored a bill that has been dubbed by an independent agency, such as the ACLU, to suppress an individual's right to vote, then answer true to Voter Suppression. Otherwise, answer false. You are free to add people who haven't been found to do either, this is a database.

>Supporting Evidence: For the blockchain, we require that you back up your claims with information. This can be the actual bill past, or some other form of evidence. These should not *just* be urls, since links can go down. We want this information to last. You can add a link to the information you are citing, but please copy the actual information and put it in here.

>And that's finally it! It's a lot, but by contributing, you will help make our democracy safer.

# Getting the blockchain

>So you want the blockchain? The whole blockchain? Then you've come to the right place! This part is actually pretty easy, but sorting through all the JSON data is on you, not us. Good luck!

>Make a GET request to https://gerrymanderingapi.herokuapp.com/blockchain (no authentication needed)

>Aaaaand... that's it. Have fun!



>
And that concludes our documentation.
