//
//  DraggableViewBackground.swift
//  testing swiping
//
//  Created by Mohamed Mahmoud HAMA on 24/04/15.
//  Copyright (c) 2015 Richard Kim. All rights reserved.
//

import Foundation
import UIKit

class DraggableViewBackground : UIView {
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //this makes it so only two cards are loaded at a time to
    //avoid performance and memory costs
    
    let MAX_BUFFER_SIZE = 9 //%%% max number of cards loaded at any given time, must be greater than 1
    let CARD_HEIGHT : CGFloat = 310  //%%% height of the draggable card
    let CARD_WIDTH : CGFloat = 310 //%%% width of the draggable card
    
    var cardsLoadedIndex : Int = 0 //%%% the index of the card you have loaded into the loadedCards array last
    var loadedCards = [DraggableView]() //%%% the array of card loaded (change max_buffer_size to increase or decrease the number of cards this holds)
    
    //var menuButton : UIButton
    //var messageButton : UIButton
    var checkButton : UIButton
    var xButton : UIButton
    
    var exampleCardLabels : AnyObject = [] //%%% all the labels I'm using as example data at the moment
    var allCards = [DraggableView]() //%%% all the cards
    
    override init(frame: CGRect) {
        //menuButton = UIButton()
        //messageButton = UIButton()
        checkButton = UIButton()
        xButton = UIButton()
        super.init(frame: frame)
        self.setupView()
        exampleCardLabels = ["first", "second", "third", "fourth", "fifth", "six", "seven", "eight", "nine"] //%%% placeholder for card-specific information
        cardsLoadedIndex = 0;
        self.loadCards()
    }
    
    //  Frontend UI styling happening here
    func setupView() {
        // Styling background
        self.backgroundColor = UIColor.whiteColor()
        
        //  Styling menuButton
        //menuButton = UIButton(frame: CGRectMake(17, 34, 22, 15))
        //menuButton.setImage(UIImage(named: "menuButton"), forState: UIControlState.Normal)
        
        //  Styling messageButton
        //messageButton = UIButton(frame: CGRectMake(284, 34, 18, 18))
        //messageButton.setImage(UIImage(named: "messageButton"), forState: UIControlState.Normal)
        
        //  Styling xButton
        xButton = UIButton(frame: CGRectMake(40, 485, 130, 130))
        xButton.setImage(UIImage(named: "xButton"), forState: UIControlState.Normal)
        
        //  Add target for checkButton (Swipe Left)
        xButton.addTarget(self, action: "swipeLeft", forControlEvents: UIControlEvents.TouchUpInside)
        
        //  Styling checkButton
        checkButton = UIButton(frame: CGRectMake(200, 485, 130, 130))
        checkButton.setImage(UIImage(named: "checkButton"), forState: UIControlState.Normal)
        
        //  Add target for checkButton (Swipe Right)
        checkButton.addTarget(self, action: "swipeRight", forControlEvents: UIControlEvents.TouchUpInside)
        
        // Add subviews
        //self.addSubview(menuButton)
        //self.addSubview(messageButton)
        self.addSubview(xButton)
        self.addSubview(checkButton)
    }
    
    func loadCards() {
        if(exampleCardLabels.count > 0){
            //%%% if the buffer size is greater than the data size, there will be an array error, so this makes sure that doesn't happen
            var numLoadedCardsCap = exampleCardLabels.count > MAX_BUFFER_SIZE ? MAX_BUFFER_SIZE : exampleCardLabels.count
            
            //%%% loops through the exampleCardsLabels array to create a card for each label.  This should be customized by removing "exampleCardLabels" with your own array of data
            for (var i = 0; i < exampleCardLabels.count; i++) {
                var newCard : DraggableView = self.createDraggableViewWithDataAtIndex(i)
                allCards.append(newCard)
                
                if(i < numLoadedCardsCap) {
                    //%%% adds a small number of cards to be loaded
                    loadedCards.append(newCard)
                }
            }
        }
        
        //%%% displays the small number of loaded cards dictated by MAX_BUFFER_SIZE so that not all the cards
        // are showing at once and clogging a ton of data
        for (var i = 0; i < loadedCards.count; i++) {
            if (i > 0) {
                self.insertSubview(loadedCards[i] as UIView, belowSubview: loadedCards[i-1] as UIView)
            } else {
                self.addSubview(loadedCards[i] as UIView)
            }
            cardsLoadedIndex++; //%%% we loaded a card into loaded cards, so we have to increment
        }
    }
    
    //%%% action called when the card goes to the left.
    // This should be customized with your own action
    
    func cardSwipedLeft(card: UIView) {
        //do whatever you want with the card that was swiped
        //    DraggableView *c = (DraggableView *)card;
        loadedCards.removeAtIndex(0)  //%%% card was swiped, so it's no longer a "loaded card"
        
        //%%% if we haven't reached the end of all cards, put another into the loaded cards
        if(cardsLoadedIndex < allCards.count) {
            loadedCards.append(allCards[cardsLoadedIndex])
            
            //%%% loaded a card, so have to increment count
            cardsLoadedIndex++
            self.insertSubview(loadedCards[MAX_BUFFER_SIZE-1] as UIView, belowSubview: loadedCards[MAX_BUFFER_SIZE-2] as UIView)
            
        }
    }
    
    //%%% action called when the card goes to the left.
    // This should be customized with your own action
    func cardSwipedRight(card: UIView) {
        //do whatever you want with the card that was swiped
        //    DraggableView *c = (DraggableView *)card;
        
        loadedCards.removeAtIndex(0)  //%%% card was swiped, so it's no longer a "loaded card"
        
        //%%% if we haven't reached the end of all cards, put another into the loaded cards
        if(cardsLoadedIndex < allCards.count) {
            loadedCards.append(allCards[cardsLoadedIndex])
            //%%% loaded a card, so have to increment count
            cardsLoadedIndex++
            self.insertSubview(loadedCards[MAX_BUFFER_SIZE-1] as UIView, belowSubview: loadedCards[MAX_BUFFER_SIZE-2] as UIView)
        }
    }
    
    //%%% when you hit the right button, this is called and substitutes the swipe
    func swipeRight() {
        var dragView : DraggableView = loadedCards.first!
        dragView.overlayView.mode = GGOverlayViewMode.GGOverlayViewModeLeft
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            dragView.overlayView.alpha = 1
        })
        //loadedCards.setMode(GGOverlayViewMode.GGOverlayViewModeRight)
        cardSwipedRight(loadedCards.first!)
        dragView.rightClickAction()
    }
    
    func swipeLeft() {
        var dragView : DraggableView = loadedCards.first!
        dragView.overlayView.mode = GGOverlayViewMode.GGOverlayViewModeLeft
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            dragView.overlayView.alpha = 1
        })
        //loadedCards.setMode(GGOverlayViewMode.GGOverlayViewModeLeft)
        ///overlayView.setMode(GGOverlayViewMode.GGOverlayViewModeLeft)
        cardSwipedLeft(loadedCards.first!)
        dragView.leftClickAction()
    }
    
    //%%% creates a card and returns it.  This should be customized to fit your needs.
    // use "index" to indicate where the information should be pulled.  If this doesn't apply to you, feel free
    // to get rid of it (eg: if you are building cards from data from the internet)
    
    func createDraggableViewWithDataAtIndex(index: Int) -> DraggableView{
        var draggableView : DraggableView = DraggableView(frame: CGRectMake((self.frame.size.width - CARD_WIDTH)/2, (self.frame.size.height - CARD_HEIGHT)/4, CARD_WIDTH, CARD_HEIGHT)) /////// ICI DIVISION PAR 4
        //%%% placeholder for card-specific information
        draggableView.information.text = exampleCardLabels.objectAtIndex(index) as? String
        return draggableView
    }
}