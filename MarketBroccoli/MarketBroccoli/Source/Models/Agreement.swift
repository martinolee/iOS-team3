//
//  Agreement.swift
//  MarketBroccoli
//
//  Created by macbook on 2020/03/31.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation

class Agreement {
  var total = false
  var usingLaw = false {
    didSet {
      if usingLaw && personalEseesntial && personalNotEssential && freeShipping && sms && emailCheck && ageCheck {
        total = true
      } else {
        total = false
      }
    }
  }
  var personalEseesntial = false {
    didSet {
      if usingLaw && personalEseesntial && personalNotEssential && freeShipping && sms && emailCheck && ageCheck {
        total = true
      } else {
        total = false
      }
    }
  }
  var personalNotEssential = false {
    didSet {
      if usingLaw && personalEseesntial && personalNotEssential && freeShipping && sms && emailCheck && ageCheck {
        total = true
      } else {
        total = false
      }
    }
  }
  var freeShipping = false {
    didSet {
      if usingLaw && personalEseesntial && personalNotEssential && freeShipping && sms && emailCheck && ageCheck {
        total = true
      } else {
        total = false
      }
    }
  }
  var sms = false {
    didSet {
      if usingLaw && personalEseesntial && personalNotEssential && freeShipping && sms && emailCheck && ageCheck {
        total = true
      } else {
        total = false
      }
    }
  }
  var emailCheck = false {
    didSet {
      if usingLaw && personalEseesntial && personalNotEssential && freeShipping && sms && emailCheck && ageCheck {
        total = true
      } else {
        total = false
      }
    }
  }
  var ageCheck = false {
    didSet {
      if usingLaw && personalEseesntial && personalNotEssential && freeShipping && sms && emailCheck && ageCheck {
        total = true
      } else {
        total = false
      }
    }
  }
}
