import os
import re

replacements = [
    (r"import '.*config/app_colors\.dart';", "import 'package:fest_app/app/core/theme/app_colors.dart';"),
    (r"import '.*config/app_sizes\.dart';", "import 'package:fest_app/app/core/theme/app_sizes.dart';"),
    (r"import '.*config/app_theme\.dart';", "import 'package:fest_app/app/core/theme/app_theme.dart';"),
    (r"import '.*core/const/app_const\.dart';", "import 'package:fest_app/app/core/values/app_const.dart';"),
    (r"import '.*core/models/event_model\.dart';", "import 'package:fest_app/app/data/models/event_model.dart';"),
    (r"import '.*core/models/notification_model\.dart';", "import 'package:fest_app/app/data/models/notification_model.dart';"),
    (r"import '.*core/models/sports_event_model\.dart';", "import 'package:fest_app/app/data/models/sports_event_model.dart';"),
    (r"import '.*core/models/timeline_model\.dart';", "import 'package:fest_app/app/data/models/timeline_model.dart';"),
    (r"import '.*core/services/auth_service\.dart';", "import 'package:fest_app/app/data/services/auth_service.dart';"),
    (r"import '.*core/services/notification_services\.dart';", "import 'package:fest_app/app/data/services/notification_services.dart';"),
    
    (r"import '.*shared/widgets/custom_app_bar\.dart';", "import 'package:fest_app/app/global_widgets/custom_app_bar.dart';"),
    (r"import '.*shared/widgets/animated_theme_toggle\.dart';", "import 'package:fest_app/app/global_widgets/animated_theme_toggle.dart';"),
    (r"import '.*shared/widgets/announcement_card\.dart';", "import 'package:fest_app/app/global_widgets/announcement_card.dart';"),
    (r"import '.*shared/widgets/announcement_detail_dialog\.dart';", "import 'package:fest_app/app/global_widgets/announcement_detail_dialog.dart';"),
    (r"import '.*shared/widgets/eventCard\.dart';", "import 'package:fest_app/app/global_widgets/eventCard.dart';"),
    (r"import '.*shared/widgets/sponsor_card\.dart';", "import 'package:fest_app/app/global_widgets/sponsor_card.dart';"),
    (r"import '.*shared/widgets/sports_event_card\.dart';", "import 'package:fest_app/app/global_widgets/sports_event_card.dart';"),

    (r"import '.*shared/controllers/bottom_nav_controller\.dart';", "import 'package:fest_app/app/modules/bottom_nav/controllers/bottom_nav_controller.dart';"),
    (r"import '.*shared/controllers/home_controller\.dart';", "import 'package:fest_app/app/modules/home/controllers/home_controller.dart';"),
    (r"import '.*shared/controllers/event_controller\.dart';", "import 'package:fest_app/app/modules/event/controllers/event_controller.dart';"),
    (r"import '.*shared/controllers/sports_event_controller\.dart';", "import 'package:fest_app/app/modules/sports_event/controllers/sports_event_controller.dart';"),
    (r"import '.*shared/controllers/timeline_controller\.dart';", "import 'package:fest_app/app/modules/timeline/controllers/timeline_controller.dart';"),

    (r"import '.*shared/views/splash_screen\.dart';", "import 'package:fest_app/app/modules/splash/views/splash_screen.dart';"),
    (r"import '.*shared/views/aboutus\.dart'(.*);", r"import 'package:fest_app/app/modules/aboutus/views/aboutus_view.dart'\1;"),
    (r"import '.*shared/views/sponsors_view\.dart';", "import 'package:fest_app/app/modules/sponsors/views/sponsors_view.dart';"),
    (r"import '.*shared/views/all_anouncement\._view\.dart';", "import 'package:fest_app/app/modules/announcements/views/all_announcement_view.dart';"),
    (r"import '.*shared/views/timeline\.dart'(.*);", r"import 'package:fest_app/app/modules/timeline/views/timeline_view.dart'\1;"),
    (r"import '.*shared/views/bottom_nav_view\.dart';", "import 'package:fest_app/app/modules/bottom_nav/views/bottom_nav_view.dart';"),
    (r"import '.*shared/views/event_view\.dart';", "import 'package:fest_app/app/modules/event/views/event_view.dart';"),
    (r"import '.*shared/views/event_detail_view\.dart';", "import 'package:fest_app/app/modules/event/views/event_detail_view.dart';"),
    (r"import '.*shared/views/sports_event_view\.dart';", "import 'package:fest_app/app/modules/sports_event/views/sports_event_view.dart';"),
    (r"import '.*shared/views/sports_event_detail_view\.dart';", "import 'package:fest_app/app/modules/sports_event/views/sports_event_detail_view.dart';"),
    
    (r"import '.*student/views/profile_view\.dart';", "import 'package:fest_app/app/modules/profile/views/profile_view.dart';"),
]

def process_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    new_content = content
    for pattern, repl in replacements:
        new_content = re.sub(pattern, repl, new_content)
        
    if content != new_content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated {filepath}")

for root, _, files in os.walk('lib'):
    for file in files:
        if file.endswith('.dart'):
            process_file(os.path.join(root, file))
