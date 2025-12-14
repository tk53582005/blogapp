import $ from "jquery";
import axios from "axios";
import {
  listenInactiveHeartEvent,
  listenActiveHeartEvent,
} from "./modules/handle_heart";

const handleHeartDisplay = (hasLiked) => {　
  if (hasLiked) {
    $(".active-heart").removeClass("hidden");
  } else {
    $(".inactive-heart").removeClass("hidden");
  }
};

const handleCommentForm = () => {
  $(".show-comment-form").off("click").on("click", () => {
    $(".show-comment-form").addClass("hidden");
    $(".comment-text-area").removeClass("hidden");
  });
};

const appendNewComment = (comment) => {
  $(".comments-container").append(
    `<div class="article_comment"><p>${comment.content}</p></div>`
  );
};

export const initArticle = () => {
  const dataset = $("#article-show").data();
  const articleId = dataset?.articleId;

  if (!articleId) return;

  // コメント一覧を取得
  axios.get(`/articles/${articleId}/comments`).then((response) => {
    const comments = response.data;
    comments.forEach((comment) => {
      appendNewComment(comment);
    });
  });

  handleCommentForm();

  // コメント送信
  $("#comment-form").off("submit").on("submit", (e) => {
    e.preventDefault();
    const content = $('textarea[name="comment[content]"]').val();

    if (!content) {
      window.alert("コメントを入力してください");
    } else {
      axios
        .post(`/articles/${articleId}/comments`, {
          comment: { content: content },
        })
        .then((res) => {
          const comment = res.data;
          appendNewComment(comment);
          $('textarea[name="comment[content]"]').val("");
        });
    }
  });

  // いいね状態を取得
  axios.get(`/articles/${articleId}/like`).then((response) => {
    const hasLiked = response.data.hasLiked;
    handleHeartDisplay(hasLiked);
  });

  listenInactiveHeartEvent(articleId);
  listenActiveHeartEvent(articleId);
};