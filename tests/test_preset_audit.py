import importlib.util
import pathlib
import unittest

SCRIPT = pathlib.Path(__file__).resolve().parents[1] / "scripts" / "preset-audit.py"
spec = importlib.util.spec_from_file_location("preset_audit", SCRIPT)
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)


class AuditTests(unittest.TestCase):
    def test_ordinary_label(self):
        labels, errors, critical, review = module.audit(
            "# note\n[macos>=27]\ncom.apple.adprivacyd # ads\n"
        )
        self.assertEqual(labels, ["com.apple.adprivacyd"])
        self.assertFalse(errors)
        self.assertFalse(critical)
        self.assertFalse(review)

    def test_power_critical(self):
        _, _, critical, _ = module.audit("com.apple.powerlogHelperd\n")
        self.assertEqual(critical[0][0], "com.apple.powerlogHelperd")

    def test_apple_id_warning(self):
        _, _, _, review = module.audit("com.apple.Siri.agent\n")
        self.assertEqual(review[0][0], "com.apple.Siri.agent")

    def test_reject_unexpected_content(self):
        _, errors, _, _ = module.audit("some.label ; rm -rf / \n")
        self.assertTrue(errors)

    def test_missing_entries(self):
        labels, _, _, _ = module.audit("# empty\n")
        self.assertFalse(labels)


if __name__ == "__main__":
    unittest.main()
