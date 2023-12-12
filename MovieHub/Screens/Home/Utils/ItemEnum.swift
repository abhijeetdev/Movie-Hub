//
//  ItemEnum.swift
//  MovieHub
//
//  Created by Abhijeet Banarase on 10/12/2023.
//

import Foundation

struct ShardedItem<ShardingKey, Item> : Hashable
    where ShardingKey:Hashable, Item:Hashable
{
    let shard: ShardingKey
    let item: Item
}

enum ItemEnum: Hashable {
    case movie(ShardedItem<SectionLayout, Movie>)
    case person(People)
}
