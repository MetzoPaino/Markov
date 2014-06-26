//
//  Scrambler.swift
//  Markov
//
//  Created by William Robinson on 26/06/2014.
//  Copyright (c) 2014 William Robinson. All rights reserved.
//

import UIKit

class Scrambler: NSObject {
	
	let sentenceMaxLength = 20
	
	// Generate a scrambled sentence
	
	func generateScrambledSentence(originalArray: String[]) -> String[] {
		
		var corpus = stripArray(originalArray)
		println(corpus)

		let sentenceLength = generateSentenceLength(corpus.count)
		println("Sentence Length = \(sentenceLength)")
		
		var randomSeed = generateSeed(corpus.count)
		println("Random Seed \(randomSeed)")
		
//		var scrambledSentence = generateStartingWords(randomSeed, wordCollection: corpus)
//		println("Starting Sentence \(scrambledSentence)")
//		
//		var nextWord = generateNextWord(scrambledSentence.firstWord, secondWord: scrambledSentence.secondWord, corpus: corpus)
//		println("Next Word \(nextWord)")
		
		var markovConstructedArray: String[] = []
		
		
		do {
			
			if
			
		} while markovConstructedArray.count < sentenceLength
		
		
		while markovConstructedArray.count < sentenceLength {
			
			if markovConstructedArray.count == 0 {
				
				var startOfMarkovSentence = generateStartingWords(randomSeed, wordCollection: corpus)
				markovConstructedArray.append(startOfMarkovSentence.firstWord)
				markovConstructedArray.append(startOfMarkovSentence.secondWord)
				println("Starting \(markovConstructedArray)")

			} else {
				
				var nextWord = generateNextWord(markovConstructedArray[markovConstructedArray.count - 2], secondWord: markovConstructedArray[markovConstructedArray.count - 1], corpus: corpus)
				markovConstructedArray.append(nextWord)
				println("Now \(markovConstructedArray)")

			}
			
		}
		
		
		

		return originalArray
	}
	
	// Take the original array of strings & make a new array with each word as a seperate element

	func stripArray(originalArray: String[]) -> String[] {
		
		var strippedArray: String[] = []
		var unwantedCharacters = NSCharacterSet(charactersInString:"()\n ")
		
		for snippet in originalArray {
			
			var array = snippet.componentsSeparatedByCharactersInSet(unwantedCharacters)
			
			for word in array {
				
				strippedArray.append(word)
				
			}
		}
		
		return strippedArray
	}
	
	// Generate a random sentence length
	
	func generateSentenceLength(amountOfWords: Int) -> Int {
		
		var sentenceLength = 0
		
		if amountOfWords <= 20 {
			
			var sentenceLength = Int(arc4random_uniform(UInt32(amountOfWords)) + 1)
			
		} else {
			
			sentenceLength = Int(arc4random_uniform(UInt32(sentenceMaxLength)) + 1)
		}
		
		if sentenceLength < 3 {
			
			generateSentenceLength(amountOfWords)
			
		}
		
		return sentenceLength
	}
	
	// Generate a random seed
	
	func generateSeed(amountOfWords: Int) -> Int {
		
		var seed = Int(arc4random_uniform(UInt32(amountOfWords)) + 1)
		
		return seed
	}
	
	// Generate Section Length
	
	func generateSectionLength() -> Int {
		
		return Int(arc4random_uniform(UInt32(10)))
		
	}
	
	// Generate Starting Words
	
	func generateStartingWords(seed: Int, wordCollection: String[]) -> (firstWord: String, secondWord: String) {
		
		let firstWord = wordCollection[seed]
		let secondWord = wordCollection[seed + 1]
		
		return (firstWord, secondWord)
	}
	
	// Generate next Word
	// We take the last two words of the sentence and then scan for the next word, if more than one result it can either be weighted, or randomised
	
	func generateNextWord(firstWord: String, secondWord: String, corpus: String[]) -> String {
		
		var seed = 0
		var nextWordArray: String[] = []
		
		for word in corpus {
			
			// If the string matches our first word, and the word after it also matches we add it to the nextWordArray
			if word == firstWord && corpus[seed + 1] == secondWord {
				
				
				nextWordArray.append(corpus[seed + 2])
				
			}
			seed++
		}
		println("Next Word Array \(nextWordArray)")
		return nextWordArray[Int(arc4random_uniform(UInt32(nextWordArray.count)))]
	}

}
