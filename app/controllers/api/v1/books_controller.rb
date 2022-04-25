# frozen_string_literal: true

module Api
  module V1
    class BooksController < ApplicationController
      before_action :set_book, only: %i[update show destroy]

      def index
        @books = Book.includes(:category)
        render json: BooksRepresenter.new(@books).as_json
      end

      def create
        @book = Book.create(book_params)
        if @book.save
          render json: BookRepresenter.new(@book).as_json, status: :created
        else
          render json: @book.errors, status: :unprocessable_entity
        end
      end

      def show
        render json: BookRepresenter.new(@book).as_json
      end

      def update
        @book.update(book_params)
        head :no_content
      end

      def destroy
        @book.destroy
        head :no_content
      end

      private

      def book_params
        params.permit(:title, :author, :category_id)
      end

      def set_book
        @book = Book.find(params[:id])
      end
    end
  end
end
