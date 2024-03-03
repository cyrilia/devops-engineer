#!/bin/bash

# Question 1: Cameroonian food choices
echo "Question 1: Which Cameroonian dish would you choose: 
1) Okok and Cassava 
2) Ndole with Miondo 
3) Water fufu and Eru 
4) Fufu corn with Egusi soup 
5) Puff-Puff, Beans and Pap"
read -p "Enter the number of your choice: " food_choice

case $food_choice in
    1)
        echo "Great choice. Enjoy your Okok and Cassava!";;
    2)
        echo "I hope it comes with crayfish, hahah!. I am sure you will like your Ndole with Miondo!";;
    3)
        echo "Eat with precaution, you might become addicted. Please enjoy your Water fufu and Eru!";;
    4)
        echo "Yummy, you're gonna love it. Enjoy your Fufu corn with Egusi soup!";;
    5)
        echo "The best choice for a Sunday morning meal! Enjoy your Puff-Puff, Beans and Pap!";;
    *)
        echo "Sorry, that’s not on the list. Your options are 1, 2, 3, 4, or 5. You may give it another try!";;
esac

# Question 2: Travel destinations
echo "Question 2: Choose a travel destination:
1) Paris, France
2) Tokyo, Japan
3) Rio de Janeiro, Brazil
4) Cape Town, South Africa"
read -p "Enter the number of your choice: " travel_choice

case $travel_choice in
    1)
        echo "Great choice! Ever fancied a croissant while seeing the Eiffel tower? Well, it's your opportunity to enjoy your time in Paris, France!";;
    2)
        echo "Exciting! Have a fantastic experience in Tokyo, Japan!";;
    3)
        echo "Wonderful! Will definitely recommend to visit during the carnival to fully observe the beauty of Rio de Janeiro, Brazil!";;
    4)
        echo "Fantastic! Come prepared for a safari to explore the wonders of Cape Town, South Africa!";;
    *)
        echo "Sorry, your option is not on the list. Kindly select between 1, 2, 3, or 4.";;
esac

# Question 3: AFCON winner of 2017
echo "Question 3: Who won the AFCON (African Cup of Nations) in 2017?
1) Egypt
2) Cameroon
3) Nigeria
4) Senegal"
read -p "Enter the number of your choice: " afcon_winner

case $afcon_winner in
    1)
        echo "Nope, that's incorrect. Egypt was not the 2017 AFCON winner. Please try again!";;
    2)
        echo "Correct! Cameroon (The continent) did in fact win the AFCON in 2017. Well done!";;
    3)
        echo "Unfortunately, that's incorrect. Though Nigeria is a neighbouring country to the winner, they did not win the AFCON in 2017. Please try again!";;
    4)
        echo "I am sorry, that's not correct. Senegal did not yet have the required level to win the AFCON in 2017. Please try again!";;
    *)
        echo "Sorry, that’s not on the list. Please choose between 1, 2, 3, or 4.";;
esac
