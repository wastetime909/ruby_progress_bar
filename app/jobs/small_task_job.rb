class SmallTaskJob < ApplicationJob
  queue_as :default

  def perform(current_user_id, i, total_count)
    sleep rand
    current_user = User.find(current_user_id)

    Turbo::StreamsChannel.broadcast_action_to ["heavy_task_channel", current_user.to_gid_param].join(":"),
      action: "append",
      target: "heavy_task", 
      content: "<div></div>"
  end
end
