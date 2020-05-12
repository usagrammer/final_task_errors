class Status < ActiveHash::Base
  self.data = [
    {id: 1, example: '---'}, 
    {id: 2, example: '新品、未使用'}, 
    {id: 3, example: '未使用に近い'},
    {id: 4, example: '目立った傷や汚れなし'}, 
    {id: 5, example: 'やや傷や汚れあり'}, 
    {id: 6, example: '傷や汚れあり'},
    {id: 7, example: '全体的に状態が悪い'}
  ]
end