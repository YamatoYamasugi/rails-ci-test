class Api::V1::MemosController < ApplicationController
    def index
        memos = Memo.all
        render json: memos
    end
    # ストロングパラメータに丸投げパターン
    def create
        Memo.create(memo_params)
        head :created
    end
    private
    # ストロングパラメータを使うことで、限られた入力だけに絞ることができる
        def memo_params
            params.permit(:title, :content)
        end
    
end
