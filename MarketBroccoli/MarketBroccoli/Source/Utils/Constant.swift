//
//  Constant.swift
//  MarketBroccoli
//
//  Created by Hongdonghyun on 2020/03/20.
//  Copyright © 2020 Team3. All rights reserved.
//

import UIKit

class Categories {
  static let HomeCategory = ["컬리추천", "신상품", "베스트", "알뜰쇼핑", "이벤트"]
  static let HomeMDCategory = [
    " 채소 ", " 과일･견과･쌀 ", " 수산･해산･건어물 ", " 정육･계란 ",
    " 국･반찬･메인요리 ", " 샐러드･간편식 ", " 면･양념･오일 ", " 음료･우유･떡･간식 ",
    " 베이커리･치즈･델리 ", " 건강식품 ", " 생활용품 ", " 주방용품 ", " 가전제품 ",
    " 베이비･키즈 ", " 반려동물 "
  ]
  static let DetailCategory = [" 상품설명 ", " 상품이미지 ", " 상세정보 ", " 후기 ", " 상품문의 "]
}

class WhyKurly {
  static let icons: [UIImage] = [
    UIImage(named: "whykurly1")!,
    UIImage(named: "whykurly2")!,
    UIImage(named: "whykurly3")!,
    UIImage(named: "whykurly4")!,
    UIImage(named: "whykurly5")!
  ]
  
  static let titles: [String] = [
    "깐깐한 상품위원회",
    "차별화된 Kurly Only 상품",
    "신선한 풀콜드체인 배송",
    "고객, 생상자를 위한 최선의 가격",
    "환경을 생각하는 지속 가능한 유통"
  ]
  
  static let descriptions: [String] = [
    "나와 내 가족이 먹고 쓸 상품을 고르는 마음으로 매주 상품을 직접 먹어보고, 경험해보고 성분, 맛, 안정성 등 다각도의 기준을 통과한 상품만을 판매합니다.",
    "전국 각지와 해외의 훌륭한 생산자가 믿고 선택하는 파트너, 마켓컬리. 2천여 개가 넘는 컬리 단독 브랜드, 스펙의 Kurly Only 상품을 믿고 만나보세요.",
    "온라인 업계 최초로 산지에서 문 앞까지 상온, 냉장, 냉동 상품을 분리 포장 후 최적의 온도를 유지하는 냉장 배송 시스템, 풀콜드체인으로 상품을 신선하게 전해드립니다.",
    "매주 대형 마트와 주요 온라인 마트의 가격 변동 상황을 확인해 신선식품은 품질을 타협하지 않는 선에서 최선의 가격으로, 가공식품은 언제나 합리적인 가격으로 정기 조정합니다.",
    "친환경 포장재부터 생산자가 상품에만 집중할 수 있는 직매입 유통구조까지, 지속 가능한 유통을 고민하며 컬리를 있게 하는 모든 환경(생산자, 커뮤니티, 직원)이 더 나아질 수 있도록 노력합니다."
  ]
}
