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
    def destroy
        # クライアントより渡されたパラメーター`id`の値を用いて検索したレコードを取得
        @memo = Memo.find(params[:id])
        # 対象のレコードを削除
        if @memo.destroy
            # 削除が成功した場合は削除したレコードをJSONで返す
            render json: @memo, status: :ok
        else
            # 削除失敗の場合はエラーを返す
            render json: { error: "Failed to delete resource" }, status: :unprocessable_entity
        end
    end
    def update
        # クライアントより渡されたパラメーター`id`の値を用いて検索したレコードを取得
        @memo = Memo.find(params[:id])
        # クライアントからのリクエストパラメータを取得しその値を用いてレコードをアップデート
        if @memo.update(memo_params)
            # 更新が成功した場合、更新したレコードをJSONで返す
            render json: @memo, status: :ok
        else
            # 更新が失敗した場合はエラーを返す
            render json: @memo.errors, status: :bad_request
        end
    end
    private
        # ストロングパラメータを使うことで、限られた入力だけに絞ることができる
        def memo_params
            params.permit(:title, :content)
        end
end
